//
//  TentCreationView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/9/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import CoreLocation

struct TentCreationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var locationManager: LocationManager
    @EnvironmentObject var tentConfig: TentConfig
    @State var showAlert: Bool = false
    @State var showLoading: Bool = false
    @State private var radius: Double = 0
    
    var tentManagement: TentManagement = TentManagement()
    
    var body: some View {
        LoadingView(message: "Creating...", isShowing: $showLoading) {
            
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
                
                MapView(currentPosition: self.locationManager.currentLocation, circleRadius: self.radius + 3)
                    .frame(height:300)
                    .padding(.bottom, 50)
                
                Text("Radius:")
                    .font(.body)
                    .foregroundColor(.green)
                
                Slider(value: self.$radius, in: -2...3, step: 0.01)
                    .frame(width: 300)
                    .padding(.bottom,50)
                
                Button(action:{self.tentManagement.createTent(location: self.locationManager.currentLocation, radius: (100 * (self.radius + 3))/1000, config: self.tentConfig, displayAlert:self.$showAlert, loadingAlert: self.$showLoading, completion: {status in
                    if(status){
                        self.presentationMode.wrappedValue.dismiss()
                    }
                })}){
                    Text("Build a new Tent")
                        .font(.body)
                        .foregroundColor(.green)
                }.alert(isPresented: self.$showAlert, content: {
                    Alert(title: Text("Invaild Code"), message: Text("This Isn't a valid code"), dismissButton: .default(Text("Ok!")))
                })
                
                
            }
        }
    }
}


