//
//  ImageUploadManager.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 3/6/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import Foundation
import UIKit

struct RawImage {
    let image: UIImage
    let tentImage: TentImage
}

class ImageUploadQueue {
    let uploadManager: UploadManager
    let tentConfig: TentConfig
    var imageQueue: [RawImage] = []
    var sequential: Bool = true //Run the upload functions one at a time waiting for completion or run the upload funciton on every item in the queue
    var sequentialWait: Bool = false // Whether we are currently waiting on an upload
    
    init(uploadManager: UploadManager,tentConfig: TentConfig){
        self.uploadManager = uploadManager
        self.tentConfig = tentConfig
    }
    
    func addImage(image: UIImage, tentImage: TentImage){
        imageQueue.insert(RawImage(image: image, tentImage: tentImage), at: 0)
        self.runQueue()
    }
    
    func uploadImage(image: RawImage, completion: @escaping (UploadErrors) -> Void ){
        self.uploadManager.uploadImage(name: image.tentImage.id.uuidString, image: image.image){
            downloadURL, uploadError in
            
            guard uploadError == .none else {
                completion(uploadError)
                return
            }
            DispatchQueue.main.async{
                image.tentImage.setUploadStatus(uploadStatus: .uploaded)
                image.tentImage.changeImageURL(newURL: downloadURL)
            }
            completion(.none)
        }
    }
    
    // Starts the upload process on the current images in the imageQueue
    func runQueue(){
        DispatchQueue.global(qos: .utility).async {
            guard self.imageQueue.count > 0 else { return }
            
           
            if(self.sequential && !self.sequentialWait){ //Should be sequential and currently not processing a queue
                let imageToUpload = self.imageQueue.popLast()!
                self.sequentialWait = true
                
                self.uploadImage(image: imageToUpload){
                    uploadError in
                    print(uploadError)
                    print("Completed Upload of Image")
                    self.sequentialWait = false
                    self.runQueue()
                }
                
            }
            else {
                
            }
            
        }
    }
    
    
}
