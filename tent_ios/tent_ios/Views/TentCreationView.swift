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
    @EnvironmentObject var tentConfig: TentConfig
    @State  var showAlert: Bool = false
    @State private var radius: Double = 0
    
    var locationManager = CLLocationManager()

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

            MapView()
                .frame(height:300)
                .padding(.bottom, 50)
            
            Text("Radius:")
                .font(.body)
                .foregroundColor(.green)
            
            Slider(value: $radius, in: -100...100, step: 0.1)
                .frame(width: 300)
                .padding(.bottom,50)
            
            Button(action:{}){
                    Text("Build a new Tent")
                        .font(.body)
                        .foregroundColor(.green)
                }.alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Invaild Code"), message: Text("This Isn't a valid code"), dismissButton: .default(Text("Ok!")))
                })
            
            
        }
    }
}

struct TentCreationView_Previews: PreviewProvider {
    static var previews: some View {
        TentCreationView()
    }
}
