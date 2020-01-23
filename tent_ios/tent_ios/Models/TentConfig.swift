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
                
                self.tentHistory[self.name] = TentData(id: self.name,code: self.code, tentLoc: self.tentLocation)
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
        }
        else{
            self.tentHistory = [:]
        }
    }
    
    var tentContent: TentContent? = nil
    
    func persistData(){
        UserDefaults.standard.set(self.code, forKey: "tentCode")
        UserDefaults.standard.set(self.name, forKey: "tentName")
        TentData.saveTentHistory(arr: self.tentHistory)
    }
    
    
    
}
