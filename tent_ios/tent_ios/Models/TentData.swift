//
//  TentData.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/23/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import Foundation

struct TentData: Codable, Hashable {
    
    
    var id: String
    var code: String
    var tentLoc: TentLocation
    var timeJoined: TimeInterval
    
    static func == (lhs: TentData, rhs: TentData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func saveTentHistory(arr: [String:TentData]){
        UserDefaults.standard.set(try? JSONEncoder().encode(arr), forKey:"tentHistory")
    }
    
    static func getTentHistory() -> [String:TentData]?{
        if let data = UserDefaults.standard.value(forKey:"tentHistory") as? Data {
            let tentData = try? JSONDecoder().decode(Dictionary<String,TentData>.self, from: data)
            return tentData
        }
        return nil
    }
}

