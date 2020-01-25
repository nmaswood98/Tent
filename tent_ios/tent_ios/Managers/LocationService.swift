//
//  locationService.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/10/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI

extension Double {
    var radian: Double { return Double(self) * .pi / 180 }
    var degree: Double { return Double(self) * 180 / .pi}
}

class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var tentConfig: TentConfig
    var alertService: AlertService
    let cLocationManager = CLLocationManager()
    
    init(tentConfig: TentConfig, alertService: AlertService){
        self.tentConfig = tentConfig
        self.alertService = alertService
        super.init()
        self.cLocationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()) {
            cLocationManager.delegate = self
            cLocationManager.desiredAccuracy = kCLLocationAccuracyBest
            startLocationUpdate()
        }
        
    }
    
    func startLocationUpdate(){
        cLocationManager.startUpdatingLocation()
    }
    
    func stopLocationUpdate(){
        cLocationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = manager.location!.coordinate
        if(self.tentConfig.code != "" && !self.tentConfig.tentLocation.islocationWithinTent(location: currentLocation)){
            self.tentConfig.leaveTent()
            self.alertService.sendAlert(title: "Not in tent", message: "You left the tent location", buttonText: "Ok")
        }

    }
}
