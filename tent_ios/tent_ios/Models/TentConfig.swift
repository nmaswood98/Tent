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
    @Published var name: String = "DefaultTent" {
        didSet{
            if let tContent = self.tentContent {
                tContent.updateTent() // Update the tent when the name changes
            }
        }
    }
    
    @Published var code: String = ""
    
    init(){
        self.code = UserDefaults.standard.string(forKey: "tentCode") ?? ""
        self.name = UserDefaults.standard.string(forKey: "tentName") ?? "DefaultTent"
    }
    
    var tentContent: TentContent? = nil
    
    func persistData(){
        UserDefaults.standard.set(self.code, forKey: "tentCode")
        UserDefaults.standard.set(self.name, forKey: "tentName")
    }
    
    
}
