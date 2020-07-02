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

enum UploadErrors {
    case connection, size, permissions, other, none
}

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
    
    func uploadImage(name:String, image: UIImage, completedUpload: @escaping (String,UploadErrors) -> Void){
        
    
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
            self.uploadToGooglePhotosTent(image: image, name: name, configName: tConfig.name, completedUpload: completedUpload)
        }
        else{
            print("Not Google Photos")
            self.uploadToPureTent(data: data, name: name, configName: tConfig.name, completedUpload: completedUpload)
        }
    }
    // MediaItemsBatchCreate.NewMediaItemResult
    func uploadToGooglePhotosTent(image: UIImage, name: String, configName: String, completedUpload: @escaping (String, UploadErrors) -> Void){
        guard let tConfig = tentConfig else {
            return;
        }
        print(tConfig.name)
        GPhotosApi.mediaItems.upload(images: [image], filenames: ["NewImage"],albumID: tConfig.name) { (resultArray) in
            if (resultArray.count > 0){
                let result = resultArray[0];
                guard result.status?.code == nil  else{
                    print(result.status!)
                    print(result.status?.code)
                    completedUpload("GooglePhotosError", UploadErrors.other)
                    return;
                }
                completedUpload("GooglePhotosComplete",UploadErrors.none);
                
                
            }
            else{
                // Handle Error
            }
        }
    }
    
    func uploadToPureTent(data: Data, name: String, configName: String, completedUpload: @escaping (String,UploadErrors) -> Void){
        let imagePath = storage.reference().child("\(configName)/" + name + ".png")
        
        _ = imagePath.putData(data, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                completedUpload("ERROR", UploadErrors.other)
                return
            }
            
            imagePath.downloadURL { (url, error) in
                guard let downloadURL = url else { return }
                self.addImageToTent(name: name, data: ["URL":downloadURL.absoluteString,"userID":self.userID])
                completedUpload(downloadURL.absoluteString,UploadErrors.none)
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
