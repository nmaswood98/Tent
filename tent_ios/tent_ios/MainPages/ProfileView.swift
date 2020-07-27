//
//  ProfileView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 7/26/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var tentProfile: TentProfile
    
    var body: some View {
        
        Button(action:{
            self.tentProfile.logOut()
        }){Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)}
        
    }
}


