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
                        Spacer()


                        
                        Button(action:{self.showTentEnterModal = true}){
                            Text((tentConfig.code == "") ? "Tent" : "Tent: \(tentConfig.code)")
                                .foregroundColor(.green)
                        }.sheet(isPresented: $showTentEnterModal, content: {
                            TentJoinView(locationManager: self.locationManager)
                                .environmentObject(self.tentConfig)
                        })
                        
                        ZStack{
                            BlurView(style: .dark)
                            
                            HStack(spacing:60){
                                
                                NavigationLink(destination: TentContentView().environmentObject(tentContent)){
                                        Rectangle()
                                            .fill(Color.red)
                                            .opacity(0.5)
                                            .frame(width: 45, height: 45)
                                }

                                Button(action:takePicture){
                                    Circle()
                                        .fill(Color.green)
                                        .opacity(0.5)
                                        .frame(width: 75)
                                        .padding(.bottom, 10)
                                }
                                
                                Button(action:{self.showTentCreationModal = true}){
                                    Rectangle()
                                        .fill(Color.blue)
                                        .opacity(0.5)
                                        .frame(width: 45, height: 45)
                                }.sheet(isPresented: $showTentCreationModal, content: {
                                    TentCreationView(locationManager: self.locationManager)
                                        .environmentObject(self.tentConfig)
                                })
                                
                            }
                            
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame( height: 125, alignment: .bottom)
                        
                        
                        /*
                        Button(action:{self.showTentEnterModal = true}){
                            Text("Enter a Tent")
                                .font(.title)
                                .foregroundColor(.green)
                        }.sheet(isPresented: $showTentEnterModal, content: {
                            TentJoinView(locationManager: self.locationManager)
                                .environmentObject(self.tentConfig)
                        })
                        */
                    
                    }
                    .edgesIgnoringSafeArea(.all)

                }
            }.navigationBarHidden(true)
    }
    
    func takePicture(){
        camera.takePicture()
    }
}


