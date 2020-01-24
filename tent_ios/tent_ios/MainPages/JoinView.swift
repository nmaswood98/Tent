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
    @EnvironmentObject var tentManagement: TentManagement
    @EnvironmentObject var loadingService: LoadingViewService
    
    @ObservedObject var locationManager: LocationManager
    @State private var code: String = ""
    @State  var showAlert: Bool = false
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
                    MapView(currentPosition: self.tentConfig.tentLocation.getCLLocationCoordinate2D(), circleRadius: self.tentConfig.tentLocation.getRadiusToDisplayOnMap(),zoom:15)
                        .cornerRadius(20)
                        .frame(height:300)
                        .padding(.top, 15)
                }
                
                TextField("Code", text:self.$code,onCommit: {
                    self.loadingService.enableLoadingDialog()
                    self.tentManagement.submitCode(value: self.code, location: self.locationManager.currentLocation, config:self.tentConfig, completion: { status in
                        self.loadingService.disableLoadingDialog()
                        if (status){
                            print("Completed")
                            UIApplication.shared.endEditing()
                            self.backTap()
                            
                        }
                        else{
                            self.showAlert = true;
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
                }.alert(isPresented: self.$showAlert, content: {
                    Alert(title: Text("Invaild Code"), message: Text("This Isn't a valid code"), dismissButton: .default(Text("Ok!")))
                })
                
                Spacer()
                
            }.padding(15)
                .padding(.top,50)
            
            
            
            
        }.onAppear{
            self.loadingService.setLoadingMessage(text: "Joining...")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01 ) {
                self.radius = 0
            }
        }
    }
}


