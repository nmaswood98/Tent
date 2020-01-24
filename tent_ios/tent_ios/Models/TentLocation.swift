//
//  Location.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/15/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import Foundation
import CoreLocation


// lat and long are in radians
// radius is in miles
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
    
    func getCLLocationCoordinate2D() -> CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: lat.degree, longitude: long.degree)
    }
    
    func getRadiusToDisplayOnMap() -> Double{
        return (self.radius * 1000)/100
    }
    
    func islocationWithinTent(location: CLLocationCoordinate2D) -> Bool{
        let deltaLat = self.lat - location.latitude.radian
        let deltaLong = self.long - location.longitude.radian
        
        let a = sin(deltaLat / 2) * sin(deltaLat / 2) + cos(location.latitude.radian) * cos(self.lat) * sin(deltaLong / 2) * sin(deltaLong / 2)
        
        let c = 2 * atan2(sqrt(a), sqrt(1-a))
        
        let tentDist = 6371 * c
        
        return tentDist <= self.radius
    }
}
