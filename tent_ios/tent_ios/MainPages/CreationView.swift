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
    @EnvironmentObject var tentManager: TentManager
    @EnvironmentObject var loadingService: LoadingViewService
    @EnvironmentObject var alertService: AlertService
    
    @State private var radius: Double = 0.1
    
    @State private var shouldLoadMap: Bool = true
    
    @State var typeSelected = 0
    @State var isPublic = false
    @State var isGPhotos = false
    @State var name = ""
    @State var keyboardOffset: CGFloat = 0
    var tentTypes = ["Google Photos","Private","Public"]
    
    
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
                            .padding(.top,30)
                    }
                    Spacer()
                }
                Spacer()
            }.padding()
            
            
            VStack{
                Spacer().frame(height: 30)
                if(self.tentConfig.code == ""){
                    Text("Current Tent: None")
                        .font(.title)
                        .foregroundColor(.green)
                }
                else{
                    Text("Current Tent: \(self.tentConfig.code)")
                        .font(.title)
                        .foregroundColor(.green)
                }
                
                if(self.shouldLoadMap){
                    
                    MapView(centerPosition: self.locationService.currentLocation, circleRadius: self.radius + 3,zoom:15)
                        .cornerRadius(20)
                        .frame(height:300)
                    
                }
                Spacer().frame(height:20)
                Picker(selection: $typeSelected,label:Text("")){
                    ForEach(0 ..< tentTypes.count){
                        Text("\(self.tentTypes[$0])")
                            .foregroundColor(Color.green)
                            .tag($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                
                
                VStack{
                    Spacer().frame(height:30)
                    Section(header:Text("Tent Name:").foregroundColor(Color.green)){
                        TextField("Enter your name", text: $name).textFieldStyle(RoundedBorderTextFieldStyle())
                    }.opacity(self.isPublic ? 1 : 0 )
                    Spacer().frame(height: 20)
                    Section(header:Text(" Tent Radius:").foregroundColor(Color.green)){
                        Slider(value: self.$radius, in: -2.8...3, step: 0.01)
                    }
                    .offset(x: 0, y: self.isPublic ? 0 : -45)
                    Spacer().frame(height:30)
                    Button(action:{
                        self.loadingService.enableLoadingDialog()
                        if(self.isGPhotos){
                            self.tentManager.createGooglePhotosTent(location: self.locationService.currentLocation, radius: (100 * (self.radius + 3))/1000, name:self.name, config: self.tentConfig,completion: {
                                status, err in
                                self.loadingService.disableLoadingDialog()
                            })
                        }
                        else{
                            self.tentManager.createTent(location: self.locationService.currentLocation, radius: (100 * (self.radius + 3))/1000, isPublic: self.isPublic, name:self.name, config: self.tentConfig, completion: {status in
                                self.loadingService.disableLoadingDialog()
                                if(status){
                                    self.backTap()
                                }
                                else{
                                    self.alertService.sendAlert(title: "Tent Creation", message: "Was unable to create a tent", buttonText: "Ok")
                                }
                            })
                        }

                        
                    }){
                            ZStack{
                                Rectangle()
                                    .fill(Color.green)
                                    .cornerRadius(5)
                                
                                
                                Text("Create Tent")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                            }
                            .frame(width:160,height:30)
                    }
                }
                .padding([.leading,.trailing])
                
                
                
                
                
                
            }.padding()

            
            
        }.offset(y: -self.keyboardOffset).onAppear{
            self.loadingService.setLoadingMessage(text: "Creating...")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.radius = 0
            }
            
            self.enableKeyboardOffset()
            self.setUpSegementedControl()
            
            
        }.onReceive([self.typeSelected].publisher.first()) { (value) in
            withAnimation{
                self.isPublic = (value == 1 ) ? false : true
                self.isGPhotos = (value == 0) ? true : false
            }
            
        }
        .frame(width:UIScreen.main.bounds.size.width,height:UIScreen.main.bounds.size.height)
        
    }
    
    func setUpSegementedControl(){
        let greenColor = UIColor(red: 102/256, green: 209/256, blue: 103/256, alpha: 1)
        UISegmentedControl.appearance().selectedSegmentTintColor = greenColor
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: greenColor], for: .normal)
    }
    
    func enableKeyboardOffset(){
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){
            notification in
            let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            withAnimation{
                self.keyboardOffset = value.height / 2

            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){
            notification in
            withAnimation{
            self.keyboardOffset = 0
            }
            
        }
    }
}


