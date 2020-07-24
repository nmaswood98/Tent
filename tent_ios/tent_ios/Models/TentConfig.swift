//
//  TentConfig.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/7/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import Foundation
import SwiftUI

class TentConfig: ObservableObject{
    @Published var name: String = "DefaultTent"
    @Published var googlePhotosID = "NONE"
    @Published var code: String = ""
    @Published var isPublic: Bool = false
    @Published var publicName: String = ""
    @Published var isGPhotos: Bool = false
    
    var tentLocation: TentLocation = TentLocation(lat: 0, long: 0, radius: 0)
    var tentHistory: [String:TentData]
    
    init(){
        self.code = UserDefaults.standard.string(forKey: "tentCode") ?? ""
        self.name = UserDefaults.standard.string(forKey: "tentName") ?? "DefaultTent"
        
        if let tHistory = TentData.getTentHistory() {
            self.tentHistory = tHistory
            if(self.name != "DefaultTent"){
                self.tentLocation = self.tentHistory[self.name]?.tentLoc ?? TentLocation(lat: 0, long: 0, radius: 0);
            }
        }
        else{
            self.tentHistory = [:]
        }
    }
    
    var tentGallery: TentGallery? = nil
    
    func setTent(code: String, id: String, name: String = "", isPublic: Bool = false, loc: TentLocation, isGPhotos: Bool = false){
        self.googlePhotosID = "NONE"
        self.code = code
        self.tentLocation = loc
        self.name = id
        self.publicName = name
        self.isPublic = isPublic
        self.isGPhotos = isGPhotos
        if let tGallery = self.tentGallery {
            tGallery.removeListnerAndUpdateTent()
    
            self.tentHistory[self.name] = TentData(id: self.name,code: self.code, name: name, type: isPublic ? "public" : "private", tentLoc: self.tentLocation, timeJoined: Date().timeIntervalSince1970)
            TentData.saveTentHistory(arr: self.tentHistory)
            
        }

    }
    
    func setGooglePhotosTent(code: String, id: String, googlePhotosID: String, name: String = "", isPublic: Bool = false, loc: TentLocation){
            self.googlePhotosID = googlePhotosID
            self.code = code
            self.tentLocation = loc
            self.name = id
            self.publicName = name
            self.isPublic = isPublic
            self.isGPhotos = true
            if let tGallery = self.tentGallery {
                tGallery.removeListnerAndUpdateTent()
        
                self.tentHistory[self.name] = TentData(id: self.name,code: self.code, name: name, type: isPublic ? "public" : "private", tentLoc: self.tentLocation, timeJoined: Date().timeIntervalSince1970)
                TentData.saveTentHistory(arr: self.tentHistory)
                
            }
       
    }
    
    
    
    func leaveTent(){
        self.code = ""
        self.name = "DefaultTent"
        self.tentLocation = TentLocation(lat: 0, long: 0, radius: 0)

        if let tGallery = self.tentGallery {
            tGallery.removeListnerAndUpdateTent()
        }
        
    }
    
    func persistData(){
        UserDefaults.standard.set(self.code, forKey: "tentCode")
        UserDefaults.standard.set(self.name, forKey: "tentName")
        TentData.saveTentHistory(arr: self.tentHistory)
    }
    
    
    
}
