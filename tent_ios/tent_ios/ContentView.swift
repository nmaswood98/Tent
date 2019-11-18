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
                                        Image("gallery")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                }
                                .buttonStyle(PlainButtonStyle())


                                Button(action:takePicture){
                                        ZStack{
                                            Circle()
                                                .fill(Color.gray)
                                                .opacity(1)
                                            Circle()
                                                .fill(Color.white)
                                                .opacity(1)
                                                .frame(width:65)

                                        }
                                        .frame(width: 75)
                                        .padding(.bottom, 10)

                                    }
                                
                                Button(action:{self.showTentCreationModal = true}){
                                    Image("tent")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .padding(.top, 5)
                                }.sheet(isPresented: $showTentCreationModal, content: {
                                    TentCreationView(locationManager: self.locationManager)
                                        .environmentObject(self.tentConfig)
                                })
                                .buttonStyle(PlainButtonStyle())

                                
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


