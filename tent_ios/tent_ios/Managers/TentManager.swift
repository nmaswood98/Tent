//
//  tentManager.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/6/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import Foundation
import FirebaseFunctions
import SwiftUI
import CoreLocation

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

class TentManager : ObservableObject {
    
    lazy var functions = Functions.functions()
    
    
    init(){
    }
    
    func createTent(location:CLLocationCoordinate2D, radius: Double, config: TentConfig,completion: @escaping (Bool)->()){
        print("Creating Tent")
        functions.httpsCallable("CreateTent").call(["lat":location.latitude.radian,"long":location.longitude.radian,"radius":radius]){ (result,error) in
            print("Got Creation result")
            if let error = error as NSError? {
                print(error)
                completion(false);
            }
            
            
            if let data = result?.data as? NSDictionary {
                if let code = data["code"] as? String, let name = data["name"] as? String {
                    config.code = code
                    config.tentLocation = TentLocation(lat: location.latitude.radian, long: location.longitude.radian, radius: radius)
                    config.name = name
                    completion(true);
                }
            }
            
        }
    }
    
    func submitCode(value: String, location: CLLocationCoordinate2D, config: TentConfig, completion: @escaping (Bool)->()){
        print("Submitting Code")
        functions.httpsCallable("JoinTent").call(["code": value,"lat":location.latitude.radian,"long":location.longitude.radian]) { (result, error) in
            print("Got code result")
            
            if let error = error as NSError? {
                print(error)
                completion(false);
            }else
                if let text = result?.data as? String {
                    
                    if(text == "False"){
                        completion(false);
                    }
                    
            }
            if let data = result?.data as? NSDictionary {
                if let text = data["name"] as? String, let loc = data["Location"] as? NSDictionary {
                    if let lat = loc["lat"] as? Double?, let long = loc["long"] as? Double?, let radius = loc["radius"] as? Double?{
                        config.code =  value
                        config.tentLocation = TentLocation(lat: lat, long: long, radius: radius)
                        config.name = text
                        
                        completion(true);
                        
                        print("**********************************");
                        print("**********************************");
                        
                        print("**********************************");
                        
                        print("**********************************");
                        
                        print(TentData.getTentHistory())
                        print("**********************************");
                        
                        print("**********************************");
                        
                        print("**********************************");
                        
                        print("**********************************");
                        
                    }
                    
                    print("Location: \n \(config.tentLocation)");
                }
            }
            
        }
    }
    
    
    
}
