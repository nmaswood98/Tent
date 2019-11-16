//
//  TentManagementView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/6/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct TentJoinView: View {
    @ObservedObject var locationManager: LocationManager
    @State private var code: String = ""
    @State  var showAlert: Bool = false
    @State var showLoading: Bool = false
    @EnvironmentObject var tentConfig: TentConfig
    var tentManagement: TentManagement = TentManagement()
    var body: some View {
        LoadingView(message: "Joining...", isShowing: $showLoading) {
            
            VStack(alignment: .center) {
                
                if(self.tentConfig.code == ""){
                    Text("Current Tent: None")
                        .font(.title)
                        .foregroundColor(.green)
                        .padding(.bottom,30)
                }
                else{
                    Text("Current Tent: \(self.tentConfig.code)")
                        .font(.title)
                        .foregroundColor(.green)
                        .padding(.bottom,30)
                }
                
                
                TextField("Code", text:self.$code)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                
                Button(action:{self.tentManagement.submitCode(value: self.code, location: self.locationManager.currentLocation, config:self.tentConfig, displayAlert:self.$showAlert, loadingAlert: self.$showLoading)}){
                    Text("Enter")
                        .font(.body)
                        .foregroundColor(.green)
                        .padding(.top,30)
                }.alert(isPresented: self.$showAlert, content: {
                    Alert(title: Text("Invaild Code"), message: Text("This Isn't a valid code"), dismissButton: .default(Text("Ok!")))
                })
                
            }.padding(15)
            
        }
    }
}


