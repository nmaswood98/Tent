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
    @ObservedObject var locationManager: LocationManager
    @EnvironmentObject var tentConfig: TentConfig
    @State var showAlert: Bool = false
    @State private var radius: Double = 0
    
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

            MapView(currentPosition: locationManager.currentLocation, circleRadius: radius + 3)
                .frame(height:300)
                .padding(.bottom, 50)
            
            Text("Radius:")
                .font(.body)
                .foregroundColor(.green)
            
            Slider(value: $radius, in: -2...3, step: 0.01)
                .frame(width: 300)
                .padding(.bottom,50)
            
            Button(action:{self.tentManagement.createTent(location: self.locationManager.currentLocation, radius: (100 * (self.radius + 3))/1000, config: self.tentConfig)}){
                    Text("Build a new Tent")
                        .font(.body)
                        .foregroundColor(.green)
                }.alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Invaild Code"), message: Text("This Isn't a valid code"), dismissButton: .default(Text("Ok!")))
                })
            
            
        }
    }
}


