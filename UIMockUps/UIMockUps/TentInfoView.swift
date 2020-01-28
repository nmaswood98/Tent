//
//  TentInfoView.swift
//  UIMockUps
//
//  Created by Nabhan Maswood on 1/20/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import CoreLocation

struct TentInfoView: View {
    
    @State private var radius: Double = 0.1
    @State var typeSelected = 0
    @State var showNameSelection = false
    @State var name = ""
    var tentTypes = ["Private","Public"]

    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button(action:{
                    }){
                        Text("Back")
                            .foregroundColor(.green)
                            .font(.system(size: 20))
                    }
                    .padding(.top,30)
                    .padding(.leading,20)
                    Spacer()
                }
                Spacer()
            }
            
            VStack(alignment: .center) {
                
  
                    Text("Current Tent: 1243")
                        .font(.title)
                        .foregroundColor(.green)
                        .padding(.top,35)
                
                
                    
                    MapView2(centerPosition: CLLocationCoordinate2D(latitude: 0, longitude: 0), circleRadius: 0)
                        .cornerRadius(20)
                        .frame(height:300)
                        .padding(.top, 10)
                
                Picker(selection: $typeSelected,label:Text("")){
                    ForEach(0 ..< tentTypes.count){
                        Text("\(self.tentTypes[$0])")
                            .foregroundColor(Color.green)
                            .tag($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .padding([.top])
                
                VStack{
                    

                    Spacer()

                        Section(header:Text("Tent Name:").foregroundColor(Color.green)){
                            TextField("Enter your name", text: $name).textFieldStyle(RoundedBorderTextFieldStyle()).padding([.leading,.trailing])
                        }.opacity(self.showNameSelection ? 1 : 0 )
                    

                    Spacer()

                          Section(header:Text(" Tent Radius:").foregroundColor(Color.green)){
                              Slider(value: self.$radius, in: -2.8...3, step: 0.01)
                          }.padding([.leading,.trailing])
                            .offset(x: 0, y: self.showNameSelection ? 0 : -50)



                          

                          Spacer()

                             
                          Button(action:{

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
                          }.padding(.top,5)

                          

                    Spacer()
                }
                
                
                

                
                Spacer()
                
                
            }
            .padding(15)
            .padding(.top,50)
            
        }
        .onAppear{
            let greenColor = UIColor(red: 102/256, green: 209/256, blue: 103/256, alpha: 1)
            UISegmentedControl.appearance().selectedSegmentTintColor = greenColor
             UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
              UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: greenColor], for: .normal)
        }  .onReceive([self.typeSelected].publisher.first()) { (value) in
                withAnimation{
                    self.showNameSelection = (value == 0 ) ? false : true
                }

          }
    }
}

struct TentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TentInfoView().edgesIgnoringSafeArea(.all)
    }
}
