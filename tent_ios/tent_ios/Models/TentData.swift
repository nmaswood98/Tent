//
//  TentData.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/23/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import Foundation

struct TentData: Codable {
    var code: String
    var tentLoc: TentLocation
    
    static func saveTentHistory(arr: [TentData]){
        UserDefaults.standard.set(try? JSONEncoder().encode(arr), forKey:"tentHistory")
    }
    
    static func getTentHistory() -> [TentData]?{
        if let data = UserDefaults.standard.value(forKey:"tentHistory") as? Data {
            let tentData = try? JSONDecoder().decode(Array<TentData>.self, from: data)
                return tentData
        }
        return nil
    }
}

