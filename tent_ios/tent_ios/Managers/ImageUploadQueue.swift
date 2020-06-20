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
    
    
    init(uploadManager: UploadManager,tentConfig: TentConfig){
        self.uploadManager = uploadManager
        self.tentConfig = tentConfig
    }
    
    func addImage(image: UIImage, tentImage: TentImage){
        imageQueue.insert(RawImage(image: image, tentImage: tentImage), at: 0)
        self.uploadImage(image: RawImage(image: image, tentImage: tentImage))
    }
    
    func uploadImage(image: RawImage){
        self.uploadManager.uploadImage(name: image.tentImage.id.uuidString, image: image.image){
            downloadURL in
            image.tentImage.setUploadStatus(uploadStatus: true)
            image.tentImage.changeImageURL(newURL: downloadURL)
        }
    }
    
    
}
