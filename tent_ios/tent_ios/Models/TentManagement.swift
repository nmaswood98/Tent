//
//  TentManagement.swift
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

class TentManagement : ObservableObject {
    
    lazy var functions = Functions.functions()
    

    init(){
    }
    
    func createTent(location:CLLocationCoordinate2D, radius: Double, config: TentConfig,displayAlert: Binding<Bool>, loadingAlert: Binding<Bool>,completion: @escaping (Bool)->()){
        print("Creating Tent")
    functions.httpsCallable("CreateTent").call(["lat":location.latitude.radian,"long":location.longitude.radian,"radius":radius]){ (result,error) in
            print("Got Creation result")
            loadingAlert.wrappedValue = false
            if let error = error as NSError? {
                print(error)
                displayAlert.wrappedValue = true
                completion(false);
            }
            
            
            if let data = result?.data as? NSDictionary {
                if let code = data["code"] as? String, let name = data["name"] as? String {
                    config.code = code
                    config.name = name
                    config.tentLocation = TentLocation(lat: location.latitude.radian, long: location.longitude.radian, radius: radius)
                    completion(true);
                }
            }
            
        }
        loadingAlert.wrappedValue = true
    }
    
    func submitCode(value: String, location: CLLocationCoordinate2D, config: TentConfig, displayAlert: Binding<Bool>, loadingAlert: Binding<Bool>, completion: @escaping (Bool)->()){
        print("Submitting Code")
        functions.httpsCallable("JoinTent").call(["code": value,"lat":location.latitude.radian,"long":location.longitude.radian]) { (result, error) in
            print("Got code result")
            loadingAlert.wrappedValue = false

          if let error = error as NSError? {
            print(error)
            displayAlert.wrappedValue = true
            completion(false);
          }else
            if let text = result?.data as? String {
                
                if(text == "False"){
                    displayAlert.wrappedValue = true
                }
                
          }
            if let data = result?.data as? NSDictionary {
                if let text = data["name"] as? String, let loc = data["Location"] as? NSDictionary {
                    config.code =  value
                    config.name = text
                    if let lat = loc["lat"] as? Double?, let long = loc["long"] as? Double?, let radius = loc["radius"] as? Double?{
                        config.tentLocation = TentLocation(lat: lat, long: long, radius: radius)
                        completion(true);
                    }

                    print("Location: \n \(config.tentLocation)");
                }
            }
            
        }
        loadingAlert.wrappedValue = true
    }
    

    
}
