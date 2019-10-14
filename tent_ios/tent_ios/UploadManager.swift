//
//  UploadManager.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 10/13/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import Foundation
import FirebaseStorage

class UploadManager {
    static let shared = UploadManager()
    let storage = Storage.storage()
    private init(){}
    
    func uploadImage(storagePath:String, image: UIImage){
        
        let dataOptional = image.pngData()
        guard let data = dataOptional else
        {
            print("Error getting image data")
            return
        }
        
        let imagePath = storage.reference().child(storagePath + ".png")

        let uploadTask = imagePath.putData(data, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
            print("Successfully saved file")
        }
          
    }
}
