//
//  TentProfile.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 7/26/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import Foundation
import GPhotos



class TentProfile: ObservableObject {
    @Published var isLoggedIn = false
    @Published var email = ""
    @Published var name = ""
    
    let tentConfig: TentConfig
    let tentManager: TentManager
    
    init(tentConfig: TentConfig , tentManager: TentManager){
        self.tentConfig = tentConfig
        self.tentManager = tentManager
        self.isLoggedIn = GPhotos.isAuthorized
        if(self.isLoggedIn){
            tentManager.resetGPTentHistory()
            tentConfig.leaveTent()
        }
    }
    
    func logOut(){
        GPhotos.logout()
        self.isLoggedIn = GPhotos.isAuthorized
        if(self.isLoggedIn == false){
            tentManager.resetGPTentHistory()
            tentConfig.leaveTent()
        }
        print("Logging Out")
        
        
    }
    
    func logIn(){
        
        if(self.isLoggedIn){
            tentManager.resetGPTentHistory()
            tentConfig.leaveTent()
        }
        
        if(GPhotos.isAuthorized){
            GPhotos.switchAccount(with: [.readAndAppend,.sharing]){
                status, error in
                print(status)
                self.isLoggedIn = GPhotos.isAuthorized
            }
        }else{
            GPhotos.authorize(with: [.readAndAppend,.sharing]){
                status, error in
                print(status)
                self.isLoggedIn = GPhotos.isAuthorized
            }
        }

        print("Logging In")
       
    }
}
