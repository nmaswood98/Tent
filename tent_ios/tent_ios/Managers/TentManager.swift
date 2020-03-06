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
import GPhotos

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

class TentManager : ObservableObject {
    
    lazy var functions = Functions.functions()
    
    
    init(){
    }
    
    func createTent(location:CLLocationCoordinate2D, radius: Double, isPublic: Bool, name:String, config: TentConfig,completion: @escaping (Bool)->()){
        print("Creating Tent")
        functions.httpsCallable("CreateTent").call(["newTentLoc":["lat":location.latitude.radian,"long":location.longitude.radian,"radius":radius],"public":isPublic,"tentName":name]){ (result,error) in
            print("Got Creation result")
            if let error = error as NSError? {
                print(error)
                completion(false);
            }
            
            
            if let data = result?.data as? NSDictionary {
                if let code = data["code"] as? String, let id = data["id"] as? String {
                    config.setTent(code: code, id: id, name: name, isPublic: isPublic, loc: TentLocation(lat: location.latitude.radian, long: location.longitude.radian, radius: radius))
                    completion(true);
                }
            }
            
        }
    }
    
    func createGooglePhotosTent( location: CLLocationCoordinate2D,radius: Double, name: String, config: TentConfig, completion: @escaping (Bool,String)->()){
        print("Creating Google Photos Tent")
        
        GPhotosApi.albums.create(title: name) { (albumOptional) in
            guard let album = albumOptional else {
                completion(false,"Error Creating Album")
                return;
            }
            GPhotosApi.albums.share(id: album.id) { (shareInfoOptional) in
                guard let shareInfo = shareInfoOptional else {
                    completion(false, "Error Sharing Album")
                    return;
                }
                if(shareInfo.isJoined ?? false && shareInfo.isOwned ?? false){
                    print(shareInfo.shareableUrl)
                    print(shareInfo.shareToken)
                    completion(true,"");

                }
                else{
                    completion(false,"Error Shared Album isJoined or isOwned is false");
                }
                
            }
        }
            }
    
    func submitCode(value: String, location: CLLocationCoordinate2D, name: String = "", config: TentConfig, completion: @escaping (Bool)->()){
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
                if let text = data["id"] as? String, let loc = data["Location"] as? NSDictionary {
                    if let lat = loc["lat"] as? Double?, let long = loc["long"] as? Double?, let radius = loc["radius"] as? Double?{
                        
                        config.setTent(code: value, id: text, name: name, isPublic: !(name == ""), loc: TentLocation(lat: lat, long: long, radius: radius))
                        
                        completion(true);
                        
                    }
                    
                    print("Location: \n \(config.tentLocation)");
                }
            }
            
        }
    }
    
    
    
}
