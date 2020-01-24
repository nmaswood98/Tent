//
//  TentCreationView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/9/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import CoreLocation

struct CreationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var locationService: LocationService
    @EnvironmentObject var tentConfig: TentConfig
    @EnvironmentObject var tentManagement: TentManagement
    @EnvironmentObject var loadingService: LoadingViewService
    @EnvironmentObject var alertService: AlertService
    
    @State private var radius: Double = 0.1
    
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
                    
                    MapView(centerPosition: self.locationService.currentLocation, circleRadius: self.radius + 3,zoom:15)
                        .cornerRadius(20)
                        .frame(height:300)
                        .padding(.top, 15)
                    
                }
                
                
                Text("Radius:")
                    .font(.body)
                    .foregroundColor(.green)
                    .padding(.top,10)
                
                Slider(value: self.$radius, in: -2.8...3, step: 0.01)
                    .frame(width: 300)
                    .padding(.bottom,50)
                
                Button(action:{
                    self.loadingService.enableLoadingDialog()
                    self.tentManagement.createTent(location: self.locationService.currentLocation, radius: (100 * (self.radius + 3))/1000, config: self.tentConfig, completion: {status in
                        self.loadingService.disableLoadingDialog()
                        if(status){
                            self.backTap()
                        }
                        else{
                            self.alertService.sendAlert(title: "Tent Creation", message: "Was unable to create a tent", buttonText: "Ok")
                        }
                    })}){
                        Text("Build a new Tent")
                            .font(.body)
                            .foregroundColor(.green)
                }
                
                Spacer()
                
                
            }
            .padding(15)
            .padding(.top,50)
            
        }.onAppear{
            self.loadingService.setLoadingMessage(text: "Creating...")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.radius = 0
            }
        }
    }
}


