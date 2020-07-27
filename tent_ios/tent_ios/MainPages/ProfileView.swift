//
//  ProfileView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 7/26/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import GPhotos

struct ProfileView: View {
    @EnvironmentObject var tentProfile: TentProfile
    
    var body: some View {
        VStack{
            
            Text(tentProfile.isLoggedIn ? "Your Google Photos account is authenticated" : "You are Not connected with Google Photos")
                .multilineTextAlignment(.center)
                .font(.headline)
                .frame(width: 250)
                .padding(.top, 50)
                .padding(.bottom, 100)
            
            Button(action:{
                self.tentProfile.logIn()
            }){
                Text(tentProfile.isLoggedIn ? "Switch Account" : "Log In")
                    .foregroundColor(Color.green)
                    .font(.callout)
            }
            .padding(.bottom, 40)
            .buttonStyle(PlainButtonStyle())
            

            

            
            Button(action:{
                self.tentProfile.logOut()
            }){Text("Log Out").foregroundColor(Color.green).font(.callout)}
             .buttonStyle(PlainButtonStyle())
            Spacer()
        }.navigationBarTitle("Profile")

        
    }
}


