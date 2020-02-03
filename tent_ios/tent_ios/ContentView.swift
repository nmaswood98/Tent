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
    
    let cameraKit: CameraKit
    let canvas : Canvas
    
    @EnvironmentObject var tentConfig: TentConfig
    @EnvironmentObject var alertService: AlertService
    
    @State var cameraMode = true
    
    @State var showTentJoin = false
    @State var showToolPicker = false
    
    @State var showTentCreate = false
    @State var open = false
    @State var shouldFlash = false
    @State var expandMenu = false
    @State var showLoading = true
    
    var body: some View {
        
        LoadingView() {
            
            NavigationView{
                ZStack(alignment: .center){
                    
                    CameraKitView(cameraKit: self.cameraKit).edgesIgnoringSafeArea(.all)
                    
                    if(!self.cameraMode){
                        CanvasView(canvas: self.canvas).edgesIgnoringSafeArea(.all)
                            .onAppear{
                                print("HIIIIIIII")
                        }
                    }

                    CameraSnapView(shouldFlash: self.$shouldFlash)
                    

                        
                    VStack{

                        

                        
                        Spacer()
                        
                        HStack{
                            Spacer()
                            Button(action:{
                                self.cameraMode.toggle()
                                if(self.cameraMode){
                                    self.showToolPicker = false
                                }
                            }){
                                ZStack{
                                    Rectangle()
                                        .fill(self.cameraMode ? Color.red : Color.green)
                                        .cornerRadius(5)
                                        

                                    Text(self.cameraMode ? "Draw" : "Camera")
                                        .foregroundColor(.white)
                                        .font(.system(size: 15))
                                }
                                .frame(width:60,height:20)
                            }.padding(.top,15)
                            Spacer()
                            Button(action:{
                                withAnimation{
                                    self.showTentJoin.toggle();
                                }
                            }){
                                Text((self.tentConfig.code == "") ? "Tent" : self.tentConfig.isPublic ? self.tentConfig.publicName : ("Tent: \(self.tentConfig.code)"))
                                    .foregroundColor(.green)
                                    .font(.system(size:25))
                                    .multilineTextAlignment(.center)
                            }.disabled(!(!self.showToolPicker || self.cameraMode))
    
                            Spacer()
                            Button(action:self.secondaryFeatureButton){
                                ZStack{
                                    Rectangle()
                                        .fill(Color.blue)
                                        .cornerRadius(5)
                                        

                                    Text(self.cameraMode ? "Flip" : "Tools")
                                        .foregroundColor(.white)
                                        .font(.system(size: 15))
                                }
                                .frame(width:60,height:20)
                            }.padding(.top,15)
                            Spacer()
                            
                            
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
                                        })
                                        
                                        MenuButton(text:"Create", action:{
                                            withAnimation{
                                                self.showTentCreate.toggle()
                                            }
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
                                    .opacity(self.showToolPicker ? 0 : 1)
                            }
                            
                            
                            
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame( height: self.expandMenu ? 200 : 125, alignment: .bottom)
                        .animation(.spring())
                        
                        
                        
                        
                    }
                    .edgesIgnoringSafeArea(.all)
                    
                    if(self.showTentJoin){
                        BlurContainer{
                            JoinView(backTap:{
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
                            CreationView(backTap:{
                                withAnimation{
                                    self.showTentCreate.toggle()
                                }
                            })
                        }
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                        .zIndex(1)
                        
                    }
                    
                }.environment(\.colorScheme, .dark)
            }.navigationBarHidden(false)
                .statusBar(hidden: true)
            .environment(\.colorScheme, .light)
        }
        .alert(isPresented: self.$alertService.showAlert, content: {
            Alert(title: Text(self.alertService.title), message: Text(self.alertService.message), dismissButton: .default(Text(self.alertService.buttonText)))
        })
            .onAppear{
                print("HELLO")
        }
    }
    
    func takePicture(){
        if(self.cameraMode){
            cameraKit.takePicture()
        }
        else{
            canvas.takePicture()
        }
    }
    
    func secondaryFeatureButton(){
        if(!self.cameraMode){
            self.showToolPicker = self.canvas.toggleTools()
        }
        else{
            self.cameraKit.switchCamera()
        }
    }
    
    
}


