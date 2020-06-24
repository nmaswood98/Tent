//
//  Tentimage.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/25/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import Foundation
import SwiftUI
import Kingfisher
import KingfisherSwiftUI

enum UploadState {
    case waiting, uploading, uploaded, rejected
}

class TentImage: ObservableObject, Identifiable{
    var id = UUID()
    let timeCreated: TimeInterval
    @Published var imageURL: String
    @Published var valid: Bool = false
    @Published var uploaded: UploadState = UploadState.waiting
    
    init(id:UUID,timeCreated: TimeInterval, imageURL: String, uploaded: UploadState = .uploaded){
        self.id = id
        self.timeCreated = timeCreated
        self.imageURL = imageURL
        self.valid = true
        self.uploaded = uploaded
        
    }
    
    // Passed UIImage, generates random imageURL id and stores the image in the cache under the imageURL
    init(timeCreated: TimeInterval, image: UIImage?, uploaded: UploadState = .waiting){
        self.timeCreated = timeCreated
        self.imageURL = UUID().uuidString
        self.uploaded = uploaded
        if let img = image{
            let cache = ImageCache.default
            cache.store(img, forKey: self.imageURL)
            self.valid = true
        }
        else{
            self.valid = false
        }

    }
    
    // Changes the imageURL for the current image
    // If the image is downloaded already deletes it from the cache and stores it again in the cache with the new key
    func changeImageURL(newURL: String){
        let cache = ImageCache.default
        if(cache.isCached(forKey:self.imageURL)){
            cache.retrieveImage(forKey: self.imageURL) { result in
                switch result {
                case .success(let value):
                    cache.removeImage(forKey: self.imageURL)
                    if let img = value.image{
                        cache.store(img, forKey: newURL)
                        self.imageURL = newURL
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    // returns true in the csompletion handler when the image is downloaded, if an error occurs returns false
    // If the Image is already downloaded immediately runs the completion handler
    func downloadImage( completion: @escaping (Bool) -> Void){
        
        let isCached = ImageCache.default.isCached(forKey: self.imageURL)
        if (isCached) {
            completion(true)
            return
        }
        
        guard let url = URL.init(string: self.imageURL) else {
            completion(false)
            return
        }
        
        let resource = ImageResource(downloadURL: url)
        print("DOWNLODING IMAGE AHHHHHH");
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(_):
                print("Got Image Downloaded")
                completion(true)
            case .failure(let error):
                print("Error: \(error)")
                completion(false)
            }
        }
    }
    
    func setUploadStatus(uploadStatus: UploadState){
        self.uploaded = uploadStatus
    }
    
}
