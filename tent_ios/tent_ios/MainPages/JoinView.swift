//
//  TentManagementView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/6/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct JoinView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var tentConfig: TentConfig
    @EnvironmentObject var tentManager: TentManager
    @EnvironmentObject var loadingService: LoadingViewService
    @EnvironmentObject var locationService: LocationService
    @EnvironmentObject var alertService: AlertService
    
    @State private var code: String = ""
    @State private var radius: Double = 0.1
    @State private var shouldOpenKeyboard: Bool = true
    
    @State private var shouldLoadMap: Bool = true
    
    
    var backTap: () -> ()
    var body: some View {
        
        ZStack{
            VStack{
                HStack{
                    Button(action:{
                        UIApplication.shared.endEditing()
                        self.backTap()
                    }){
                        Text("Back")
                            .foregroundColor(.green)
                            .font(.system(size: 20))
                    }
                    .padding(.top,30)
                    .padding(.leading,20)
                    Spacer()
                }
                Spacer()
            }
            
            VStack(alignment: .center) {
                
                
                if(self.tentConfig.code == ""){
                    Text("Current Tent: None")
                        .font(.title)
                        .foregroundColor(.green)
                        .padding(.top,30)
                }
                else{
                    Text("Current Tent: \(self.tentConfig.code)")
                        .font(.title)
                        .foregroundColor(.green)
                        .padding(.top,30)
                }
                
                if(self.shouldLoadMap){
                    MapView(centerPosition: self.tentConfig.tentLocation.getCLLocationCoordinate2D(), circleRadius: self.tentConfig.tentLocation.getRadiusToDisplayOnMap(),zoom:15)
                        .cornerRadius(20)
                        .frame(height:300)
                        .padding(.top, 15)
                }
                
                TextField("Code", text:self.$code,onCommit: {
                    self.loadingService.enableLoadingDialog()
                    self.tentManager.submitCode(value: self.code, location: self.locationService.currentLocation, config:self.tentConfig, completion: { status in
                        self.loadingService.disableLoadingDialog()
                        if (status){
                            print("Completed")
                            UIApplication.shared.endEditing()
                            self.backTap()
                            
                        }
                        else{
                            self.alertService.sendAlert(title: "Invalid Code", message: "This is an Invalid Code", buttonText: "Ok")
                            print("Completed but failed")
                            self.shouldOpenKeyboard = true
                            self.code = ""
                        }
                    })
                    
                })
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .autocapitalization(.allCharacters)
                    .keyboardType(.alphabet)
                    .padding(.top, 10)
                    .introspectTextField { textField in
                        if(self.shouldOpenKeyboard){
                            textField.becomeFirstResponder()
                            self.shouldOpenKeyboard = false
                        }
                }
                
                Spacer()
                
            }.padding(15)
                .padding(.top,50)
            
            
            
            
        }.onAppear{
            self.loadingService.setLoadingMessage(text: "Joining...")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01 ) {
                self.radius = 0
            }
        }
        .navigationBarHidden(true)
    }
}


