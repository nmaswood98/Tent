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


class TentGallery: ObservableObject{
    @Published var columns: [Column] = [Column(images: []),Column(images: [])]
    private var imageList: [TentImage] = [] // All images including ones that are not downloaded yet
    
    let db = Firestore.firestore()
    var tentName: String
    var tentConfig: TentConfig
    var listner: ListenerRegistration?

    
    init(tentConfig: TentConfig){
        self.tentConfig = tentConfig
        tentName = tentConfig.name

        self.updateTent()
    }
    
    func removeListnerAndUpdateTent(){
        print("Updating Tent")
        guard listner != nil else {
            return
        }
        
        if(tentConfig.name == tentName){
            return
        }
        
        self.columns = [Column(images: []),Column(images: [])]
        self.imageList = []
        tentName = tentConfig.name
        
        listner!.remove()
        
        self.updateTent()

    }
    
    func updateTent(){
        self.listner = db.collection("Tents").document(tentName).collection("Images").addSnapshotListener { querySnapshot, err in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(err!)")
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                print("changes")
                if (diff.type == .added) {
                    print("\(diff.document.documentID) => \(diff.document.data())")
                    if let url = diff.document.data()["URL"] {
                        
                        let tentImage = TentImage(timeCreated: Date().timeIntervalSince1970, imageURL: url as! String )
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
    
    func addImage(image: TentImage){
        imageList.insert(image, at: 0)
        self.arrangeImages()
    }
    
    func arrangeImages(){
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

