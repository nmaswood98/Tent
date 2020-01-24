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
    @Published var name: String = "DefaultTent" { // Last property to always get set
        didSet{
            if let tContent = self.tentContent {
                tContent.updateTent() // Update the tent when the name changes
                
                self.tentHistory[self.name] = TentData(id: self.name,code: self.code, tentLoc: self.tentLocation, timeJoined: Date().timeIntervalSince1970)
                TentData.saveTentHistory(arr: self.tentHistory)
                
            }
        }
    }
    
    @Published var code: String = ""
    
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
    
    var tentContent: TentContent? = nil
    
    func setTent(code: String, name: String, loc: TentLocation){
        self.code = code
        self.tentLocation = loc
        self.name = name

    }
    
    func persistData(){
        UserDefaults.standard.set(self.code, forKey: "tentCode")
        UserDefaults.standard.set(self.name, forKey: "tentName")
        TentData.saveTentHistory(arr: self.tentHistory)
    }
    
    
    
}
