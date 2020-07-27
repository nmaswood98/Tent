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
    
    init(){
        print(GPhotos.isAuthorized)
    }
    
    func logOut(){
        print("Logging Out")
        
        
    }
    
    func logIn(){
        print("Logging In")
    }
}
