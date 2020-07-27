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
    var googlePhotosTentJoined : [String: Bool] = [:]
    
    
    init(){
        if let oldHistory = TentManager.getGPHistory() {
            self.googlePhotosTentJoined = oldHistory;
        }
        
    }
    
    static func saveGPHistory(arr: [String:Bool]){
        UserDefaults.standard.set(try? JSONEncoder().encode(arr), forKey:"googlePhotosTentDict")
    }
    
    static func getGPHistory() -> [String:Bool]?{
        if let data = UserDefaults.standard.value(forKey:"googlePhotosTentDict") as? Data {
            let tentData = try? JSONDecoder().decode(Dictionary<String,Bool>.self, from: data)
            return tentData
        }
        return nil
    }
    
    func resetGPTentHistory(){
        self.googlePhotosTentJoined = [:]
        TentManager.saveGPHistory(arr: [:])
    }
    
    func addCodeToHistory(code: String){
        self.googlePhotosTentJoined[code] = true;
        TentManager.saveGPHistory(arr: self.googlePhotosTentJoined);
    }
    
    func removeCodeFromHistory(code: String){
        if let oldCode = self.googlePhotosTentJoined[code] {
            self.googlePhotosTentJoined[code] = nil;
            TentManager.saveGPHistory(arr: self.googlePhotosTentJoined);
        }
        
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
                                        
                    self.functions.httpsCallable("CreateGooglePhotosTent").call(["newTentLoc":["lat":location.latitude.radian,"long":location.longitude.radian,"radius":radius],"shareToken":shareInfo.shareToken,"albumID":album.id,"tentName":name]){ (result,error) in
                        print("Got Creation result")
                        if let error = error as NSError? {
                            print(error)
                            completion(false, "Error creating database entry");
                        }
                        
                        
                        if let data = result?.data as? NSDictionary {
                            if let code = data["code"] as? String, let id = data["id"] as? String {
                                config.setTent(code: code, id: id, name: name, isPublic: false, loc: TentLocation(lat: location.latitude.radian, long: location.longitude.radian, radius: radius),isGPhotos: true)
                                self.addCodeToHistory(code: code);
                                completion(true, "")
                            }
                            else{
                                completion(false,"Error at code optional unwrapping")
                            }
                        }
                        else{
                            completion(false,"Error at data result in call")
                        }
                        
                    }
                    
                    
                    
                
                }
                else{
                    completion(false,"Error Shared Album isJoined or isOwned is false");
                }
                
            }
        }
            }
    
    func joinGooglePhotosTent(shareToken: String, completion: @escaping (Bool, String )->() ){
        GPhotosApi.sharedAlbums.join(token: shareToken) { (albumOptional) in
            guard let album = albumOptional else {
                print("Failed at album, trying to get google photos tent if alrady jointed")
                self.getGooglePhotosTent(shareToken: shareToken, completion: completion);
                return;
            }

            print(album.title)
            print("From a join")
            completion(true, album.id);
                

        
        }
    }

    func getGooglePhotosTent(shareToken: String, completion: @escaping (Bool, String)->()){
        GPhotosApi.sharedAlbums.get(token: shareToken) { (albumOptional) in
            guard let album = albumOptional else {
                print("Failed at album")
                
                completion(false,"Error");
                return;
            }
            guard let shareInfo = album.shareInfo else {
                 print("Failed at shareInfo")
                completion(false,"Error");
                return;
            }
            guard let isJoined = shareInfo.isJoined else {
                print("Failed at isJoined")
                completion(false,"Error");
                return;
            }
            
            print(album.title)
            print("From a Get")

            if isJoined {
                completion(true, album.id);
                
            }
            else{
                print("Failed if Joined")
                completion(false,"Error");
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

                if let isGooglePhotos = data["googlePhotos"] as? Bool, let text = data["id"] as? String, let loc = data["Location"] as? NSDictionary {
                    if let lat = loc["lat"] as? Double?, let long = loc["long"] as? Double?, let radius = loc["radius"] as? Double?{
                        if isGooglePhotos{
                            if let shareToken = data["shareToken"] as? String {
                                print(shareToken)
                                
                                // Need to Error Handle here
                                if self.googlePhotosTentJoined[value] != nil {
                                    self.getGooglePhotosTent(shareToken: shareToken){
                                        status, googlePhotosAlbumID in
                                    
                                        guard status == true else {
                                            return;
                                        }
                                    
                                        config.setGooglePhotosTent(code: value,id: googlePhotosAlbumID, googlePhotosID: text, name: name, isPublic: !(name == ""), loc: TentLocation(lat: lat, long: long, radius: radius))
                                        completion(true);
                                    }
                                }
                                else{
                                    self.joinGooglePhotosTent(shareToken: shareToken){
                                        status, googlePhotosAlbumID in
                                    
                                        guard status == true else {
                                            return;
                                        }
                                    
                                        config.setGooglePhotosTent(code: value,id: googlePhotosAlbumID, googlePhotosID: text, name: name, isPublic: !(name == ""), loc: TentLocation(lat: lat, long: long, radius: radius))
                                        self.addCodeToHistory(code: value);
                                        completion(true);
                                    }
                                }
                            }
                                
                        }
                        else{
                            config.setTent(code: value, id: text, name: name, isPublic: !(name == ""), loc: TentLocation(lat: lat, long: long, radius: radius))
                            completion(true);
                        }
                        
                        
                        
                    }
                    
                    print("Location: \n \(config.tentLocation)");
                }
            }
            
        }
    }
    
    
    
}
