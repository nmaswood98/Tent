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
    @State var open = false
    @State var shouldFlash = false
    
    @State var expandMenu = false
    
        var body: some View {
            
            NavigationView{
                ZStack(alignment: .center){

                    CameraView(camera: camera, color: UIColor.red)
                        .edgesIgnoringSafeArea(.all)
                        .environmentObject(tentConfig)
                    
                    CameraSnapView(shouldFlash: self.$shouldFlash)
                    
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
                                .cornerRadius(30)
                            
                            VStack{
                                Spacer()
                            

                                if(self.expandMenu){
                                    Spacer()
                                    HStack(spacing:10){
                                        Spacer()
                                                  
                                        MenuButton(text:"Tents", action:{print("Tents")})
                                        MenuButton(text:"Join", action:{
                                            self.showTentEnterModal = true
                                            self.open.toggle()
                                        })
                                        .sheet(isPresented: $showTentEnterModal, content: {
                                            TentJoinView(locationManager: self.locationManager)
                                                .environmentObject(self.tentConfig)
                                        })
                                        MenuButton(text:"Create", action:{
                                            self.showTentCreationModal = true
                                            self.expandMenu.toggle()
                                            
                                        })
                                        .sheet(isPresented: $showTentCreationModal, content: {
                                            TentCreationView(locationManager: self.locationManager)
                                                .environmentObject(self.tentConfig)
                                        })

                                        Spacer()
                                    }
                                    .frame( height: 60)
                                    .transition(.offset(x: 0, y: 200))
                                    .animation(.spring())
                                }
                                
                                HStack(spacing:60){
                                    
                                    NavigationLink(destination: TentContentView().environmentObject(tentContent)){
                                            Image("gallery")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                    }
                                    .buttonStyle(PlainButtonStyle())


                                    Button(action:{
                                        self.takePicture()
                                        self.shouldFlash = true
                                    }){
                                            ZStack{
                                                Circle()
                                                    .fill(Color.gray)
                                                    .opacity(1)
                                                Circle()
                                                    .fill(Color.white)
                                                    .opacity(1)
                                                    .frame(width:65)

                                            }
                                            .frame(width: 75, height: 75)
                                            .padding(.bottom, 10)

                                        }
                                    
                                    Button(action:{
                                        withAnimation{
                                            self.expandMenu.toggle()
                                        }
                                      //  self.open.toggle()
                                    }){
                                        Image("tent")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .padding(.top, 5)
                                    }.sheet(isPresented: $showTentCreationModal, content: {
                                        TentCreationView(locationManager: self.locationManager)
                                            .environmentObject(self.tentConfig)
                                    })
                                    .buttonStyle(PlainButtonStyle())

                                    
                                }.padding()
                            }
                            

                            
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame( height: expandMenu ? 200 : 125, alignment: .bottom)
                        .animation(.spring())
                        
                        
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


