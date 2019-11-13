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
    @EnvironmentObject var tentConfig: TentConfig
     var tentManagement: TentManagement = TentManagement()
    var body: some View {
        
        VStack(alignment: .center) {
                
                if(tentConfig.code == ""){
                    Text("Current Tent: None")
                          .font(.title)
                          .foregroundColor(.green)
                          .padding(.bottom,30)
                }
                else{
                    Text("Current Tent: \(tentConfig.code)")
                          .font(.title)
                          .foregroundColor(.green)
                          .padding(.bottom,30)
                }
            
            MapView(currentPosition: locationManager.currentLocation, circleRadius: 0)
                .frame(height:300)
                .padding(.bottom, 50)

                                
                TextField("Code", text:$code)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
            
                            
            Button(action:{self.tentManagement.submitCode(value: self.code, config:self.tentConfig, displayAlert:self.$showAlert)}){
                    Text("Enter")
                        .font(.body)
                        .foregroundColor(.green)
                        .padding(.top,30)
                }.alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Invaild Code"), message: Text("This Isn't a valid code"), dismissButton: .default(Text("Ok!")))
                })
            
        }.padding(15)

    
    }
}


