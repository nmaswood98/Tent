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
    
    @State var temp = false
    @State var showTentJoin = false
    @State var showTentCreate = false
    @State var open = false
    @State var shouldFlash = false
    
    @State var expandMenu = false
    
        var body: some View {
            
            NavigationView{
                ZStack(alignment: .center){
                    

                    CameraView(camera: camera, color: UIColor.red)
                        .edgesIgnoringSafeArea(.all)
                    
                    CameraSnapView(shouldFlash: self.$shouldFlash)
                    
                    VStack{
                        Spacer()
                    
                            Button(action:{
                                withAnimation{
                                    self.showTentJoin.toggle();
                                }
                            }){
                                Text((tentConfig.code == "") ? "Tent" : "Tent: \(tentConfig.code)")
                                    .foregroundColor(.green)
                            }
                        
                        ZStack{
                            BlurView(style: .dark)
                                .cornerRadius(30)
                            
                            VStack{
                                Spacer()
                            

                                if(self.expandMenu){
                                    Spacer()
                                    HStack(spacing:10){
                                        Spacer()
                                        
                                    
                                                  
                                        NavigationLink(destination: InfoView())
                                        {
                                            
                                            ZStack{
                                                Rectangle()
                                                    .fill(Color.green)
                                                    .cornerRadius(30)
                                            
                                                Text("Tents")
                                                    .foregroundColor(.white)
                                            }
                                            
                                        }
                                        
                                        
                                        
                                        MenuButton(text:"Join", action:{
                                            withAnimation{
                                                self.showTentJoin.toggle()
                                            }
                                            self.expandMenu.toggle()
                                        })
                                     
                                        MenuButton(text:"Create", action:{
                                            withAnimation{
                                                self.showTentCreate.toggle()
                                            }
                                            self.expandMenu.toggle()
                                            
                                        })


                                        Spacer()
                                    }
                                    .frame( height: 60)
                                    .transition(.offset(x: 0, y: 200))
                                    .animation(.spring())
                                }
                                
                                HStack(spacing:60){
                                    
                                    NavigationLink(destination: GalleryView()){
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
                                    }){
                                        Image("tent")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .padding(.top, 5)
                                    }
                                    .buttonStyle(PlainButtonStyle())

                                    
                                }.padding()
                            }
                            

                            
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame( height: expandMenu ? 200 : 125, alignment: .bottom)
                        .animation(.spring())
                        
                        

                    
                    }
                    .edgesIgnoringSafeArea(.all)
                    
                    if(self.showTentJoin){
                        BlurContainer{
                            JoinView(locationManager: self.locationManager, backTap:{
                                withAnimation{
                                    self.showTentJoin.toggle()
                                }
                            })
                        }
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                        .zIndex(1)
                    }
                    
                    if(self.showTentCreate){
                        BlurContainer{
                            CreationView(locationManager: self.locationManager, backTap:{
                                withAnimation{
                                    self.showTentCreate.toggle()
                                }
                            })
                        }
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                        .zIndex(1)

                    }

                }
            }.navigationBarHidden(true)
                .statusBar(hidden: true)
    }
    
    func takePicture(){
        camera.takePicture()
    }
    

}


