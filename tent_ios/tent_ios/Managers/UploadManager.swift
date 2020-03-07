//
//  UploadManager.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 10/13/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import GPhotos

class UploadManager {
    let storage = Storage.storage()
    let db = Firestore.firestore()
    var tentName = "DefaultTent"
    let userID: String
    var tentConfig: TentConfig?
    init(tentConfig: TentConfig){
        self.tentConfig = tentConfig
        userID = Auth.auth().currentUser!.uid
    }
    
    func uploadImage(name:String, image: UIImage, gotDownloadURL: @escaping (String) -> Void){
        
    
        guard let tConfig = tentConfig else {
            return
        }
        
        let dataOptional = image.pngData()
        guard let data = dataOptional else
        {
            print("Error getting image data")
            return
        }
        
        if tConfig.isGPhotos {
            print("Is Google photos")
            self.uploadToGooglePhotosTent(image: image, name: name, configName: tConfig.name, gotDownloadURL: gotDownloadURL)
        }
        else{
            print("Not Google Photos")
            self.uploadToPureTent(data: data, name: name, configName: tConfig.name, gotDownloadURL: gotDownloadURL)
        }
    }
    // MediaItemsBatchCreate.NewMediaItemResult
    func uploadToGooglePhotosTent(image: UIImage, name: String, configName: String, gotDownloadURL: @escaping (String) -> Void){
        guard let tConfig = tentConfig else {
            return;
        }
        GPhotosApi.mediaItems.upload(images: [image], filenames: ["NewImage"],albumID: tConfig.name) { (resultArray) in
            if (resultArray.count > 0){
                let result = resultArray[0];
                guard let statusCode = result.status?.code  else{
                    // Handle ERror
                    return;
                }
                
                
                
            }
            else{
                // Handle Error
            }
        }
    }
    
    func uploadToPureTent(data: Data, name: String, configName: String, gotDownloadURL: @escaping (String) -> Void){
        let imagePath = storage.reference().child("\(configName)/" + name + ".png")
        
        _ = imagePath.putData(data, metadata: nil) { (metadata, error) in
            guard metadata != nil else { return }
            
            imagePath.downloadURL { (url, error) in
                guard let downloadURL = url else { return }
                self.addImageToTent(name: name, data: ["URL":downloadURL.absoluteString,"userID":self.userID])
                gotDownloadURL(downloadURL.absoluteString)
            }
        }
    }
    
    func addImageToTent(name:String, data:[String:String]){
        guard let tConfig = tentConfig else {
            return
        }
        db.collection("Tents").document(tConfig.name).collection("Images").document(name).setData(data)
    }
    
}
