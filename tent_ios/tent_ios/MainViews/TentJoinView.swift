//
//  TentManagementView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/6/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct TentJoinView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> 
    @ObservedObject var locationManager: LocationManager
    @State private var code: String = ""
    @State  var showAlert: Bool = false
    @State var showLoading: Bool = false
    @EnvironmentObject var tentConfig: TentConfig
    @State private var radius: Double = 0
    @State private var shouldOpenKeyboard: Bool = true

    var tentManagement: TentManagement = TentManagement()
    var body: some View {
        LoadingView(message: "Joining...", isShowing: $showLoading) {
            
            
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
                
                MapView(currentPosition: self.locationManager.currentLocation, circleRadius: self.radius + 3)
                    .frame(height:300)
                    .padding(.top, 15)
                
                TextField("Code", text:self.$code,onCommit: {
                    self.tentManagement.submitCode(value: self.code, location: self.locationManager.currentLocation, config:self.tentConfig, displayAlert:self.$showAlert, loadingAlert: self.$showLoading, completion: { status in
                            if (status){
                                print("Completed")
                                self.presentationMode.wrappedValue.dismiss()
                                UIApplication.shared.endEditing()
                                
                            }
                            else{
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
            
        }
    }
}


