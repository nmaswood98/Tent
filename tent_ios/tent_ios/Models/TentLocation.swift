//
//  Location.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/15/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import Foundation

struct TentLocation:Codable{
    var lat: Double;
    var long: Double;
    var radius: Double;
    
     init(lat: Double?, long: Double? , radius: Double?){
        if let l1 = lat, let l2 = long, let r = radius {
            self.lat = l1
            self.long = l2
            self.radius = r
        }
        else{
            print("Error Optional Unwrapping Failed")
            self.lat = 0 ;
            self.long = 0;
            self.radius = 0;
        }
    }
}
