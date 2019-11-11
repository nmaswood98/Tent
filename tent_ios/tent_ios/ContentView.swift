//
//  ContentView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 10/12/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import UIKit
import AVFoundation

struct ContentView: View {
    
    let locationManager: LocationManager
    let camera : Camera
    
    @EnvironmentObject var tentConfig: TentConfig
    @EnvironmentObject var tentContent: TentContent
    
    @State var showTentEnterModal = false
    @State var showTentCreationModal = false
    
        var body: some View {
            
            NavigationView{
                ZStack(alignment: .center){
 
                    CameraView(camera: camera, color: UIColor.red)
                        .edgesIgnoringSafeArea(.all)
                        .environmentObject(tentConfig)
                    VStack{
                        Text((tentConfig.code == "") ? "Tent" : "Tent: \(tentConfig.code)")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                        Spacer()
                        Button(action:takePicture){
                            Text("Take Picture")
                                .font(.title)
                                .foregroundColor(.green)
                        }
                        NavigationLink(destination: TentContentView().environmentObject(tentContent)){
                                Text("View Tent")
                                    .font(.title)
                                    .foregroundColor(.green)
                        }
                        Button(action:{self.showTentCreationModal = true}){
                            Text("Create a Tent")
                                .font(.title)
                                .foregroundColor(.green)
                        }.sheet(isPresented: $showTentCreationModal, content: {
                            TentCreationView(locationManager: self.locationManager)
                                .environmentObject(self.tentConfig)
                        })
                        
                        Button(action:{self.showTentEnterModal = true}){
                            Text("Enter a Tent")
                                .font(.title)
                                .foregroundColor(.green)
                        }.sheet(isPresented: $showTentEnterModal, content: {
                            TentManagementView()
                                .environmentObject(self.tentConfig)
                        })
                        
                    
                    }
                }
            }.navigationBarHidden(true)
    }
    
    func takePicture(){
        camera.takePicture()
    }
}


