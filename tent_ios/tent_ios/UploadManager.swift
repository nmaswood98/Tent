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

class UploadManager {
    static let shared = UploadManager()
    let storage = Storage.storage()
    let db = Firestore.firestore()
    let tentName = "DefaultTent"
    let userID: String
    private init(){
        userID = Auth.auth().currentUser!.uid
    }
    
    func uploadImage(name:String, image: UIImage){
        
        let dataOptional = image.pngData()
        guard let data = dataOptional else
        {
            print("Error getting image data")
            return
        }
        
        let imagePath = storage.reference().child("\(tentName)/" + name + ".png")

        _ = imagePath.putData(data, metadata: nil) { (metadata, error) in
            guard metadata != nil else { return }
            
            imagePath.downloadURL { (url, error) in
                guard let downloadURL = url else { return }
                self.addImageToTent(name: name, data: ["URL":downloadURL.absoluteString,"userID":self.userID])
            }
        }
    }
    
    func addImageToTent(name:String, data:[String:String]){
        db.collection("Tents").document(tentName).collection("Images").document(name).setData(data)
    }
    

}