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

class TentImage: ObservableObject, Identifiable{
    let id = UUID()
    let timeCreated: TimeInterval
    @Published var imageURL: String
    @Published var valid: Bool = false
    
    init(timeCreated: TimeInterval, imageURL: String){
        self.timeCreated = timeCreated
        self.imageURL = imageURL
        self.valid = true
        
    }
    
    init(timeCreated: TimeInterval, image: UIImage?){
        self.timeCreated = timeCreated
        self.imageURL = UUID().uuidString
        
        if let img = image{
            let cache = ImageCache.default
            cache.store(img, forKey: self.imageURL)
            self.valid = true
        }
        else{
            self.valid = false
        }

    }
    
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
    
    
}
