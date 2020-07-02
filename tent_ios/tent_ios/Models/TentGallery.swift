//
//  TentGallery.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/25/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import Foundation
import SwiftUI
import Kingfisher
import FirebaseFirestore
import GPhotos



// Acts differently depending on what type of tent it is
// Google Photos Tent. When joining the tent make request to grab the first page of images. When new image added set flag and then when gallery opened get image
// Regular tent. When joining grab first 15 images. When new image download in the background anywhere in the app.
class TentGallery: ObservableObject{
    @Published var columns: [Column] = [Column(images: []),Column(images: [])]
    @Published private var imageList: [TentImage] = [] // All images including ones that are not downloaded yet
    private var tentIds: [String: Bool] = [:]
    
    let db = Firestore.firestore()
    var tentName: String
    var tentConfig: TentConfig
    var listner: ListenerRegistration?

    
    init(tentConfig: TentConfig){
        self.tentConfig = tentConfig
        tentName = tentConfig.name

        self.updateTent()
    }
    
    func updateTentFromGooglePhotos(){
        
        guard self.tentConfig.isGPhotos == true else {
            print("Not Google Photos");
            return;
        }
        
        
        
        GPhotosApi.mediaItems.reloadSearch(with: .init(albumId: self.tentConfig.name, filters: nil)){
            mediaItems in
            print(mediaItems)
            self.clearImagesAndViews();
            for mediaItem in mediaItems {
                if let baseURL = mediaItem.baseUrl {
                    let downloadURL = baseURL.absoluteString + "=w288-h512";
                    self.downloadAndAddImage(id: mediaItem.id, url: downloadURL );
                }
            }
        }
    }
    
    func removeListnerAndUpdateTent(){
        print("Updating Tent")
        guard listner != nil else {
            return
        }
        
        if(tentConfig.name == tentName){
            return
        }
        
        self.clearImagesAndViews()
        tentName = tentConfig.name
        
        listner!.remove()
        
        if(tentConfig.isGPhotos){
            self.updateTentFromGooglePhotos()
        }
        else{
            self.updateTent()
        }
        
        

    }
    
    func downloadAndAddImage(id: String, url: String ){
        let tentImage = TentImage(id:UUID(uuidString: id) ?? UUID(),timeCreated: Date().timeIntervalSince1970, imageURL: url )
        tentImage.downloadImage{
            result in
            if (result){
                self.addImage(image: tentImage)
            }
            else{
                print("Couldn't download the image")
            }
        }
    }
    
    func updateTent(){
        
        guard tentConfig.isGPhotos == false else {
            return;
        }
        
        self.listner = db.collection("Tents").document(tentName).collection("Images").limit(to: 15).addSnapshotListener { querySnapshot, err in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(err!)")
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                print("changes")
                if (diff.type == .added) {
                    print("\(diff.document.documentID) => \(diff.document.data())")
                    if let url = diff.document.data()["URL"] {
        
                        self.downloadAndAddImage(id: diff.document.documentID, url: url as! String );
                        
                    }
                    
                }
                if (diff.type == .modified) {
                    print("Modified city: \(diff.document.data())")
                }
                if (diff.type == .removed) {
                    print("Removed city: \(diff.document.data())")
                }
            }
            
        }
        
    }
    
    func clearImagesAndViews(){
        self.columns = [Column(images: []),Column(images: [])]
        self.imageList = []
        self.tentIds = [:]
    }
    
    func addImage(image: TentImage){
        if(tentIds[image.id.uuidString] == nil){
            imageList.insert(image, at: 0)
            
            tentIds[image.id.uuidString] = true
            self.arrangeImages()
            
        }
    }
    
    func arrangeImages(){
        print("Arranging ITem")
        self.imageList.sort{
            tentImage1, tentImage2 in
            return tentImage1.timeCreated > tentImage2.timeCreated
        }
        
        self.columns = [Column(images: []),Column(images: [])]
        
        var count = 0
        for image in imageList{
            if(count % 2 == 0){
                self.columns[0].images.append(image)
            }
            else{
                self.columns[1].images.append(image)
            }
            count += 1
        }
        
    }

}

struct Column: Identifiable{
    let id = UUID()
    var images: [TentImage]
}

