//
//  TentHistoryView.swift
//  UIMockUps
//
//  Created by Nabhan Maswood on 1/20/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import GoogleMaps

struct TentHistoryView: View {
    var code: String
    var tentLocation: TentLocation
    var body: some View {
                ZStack{
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 4)
            VStack{
                HStack{
                    Text("Tent: " + code)
                        .foregroundColor(.black)
                        .font(.system(size: 25))
                    Spacer()
                }
                .padding(.leading,20)
                .padding(.bottom,-5)
    
                
                ZStack{
                    //(100 * (self.radius + 3))/1000
                    MapView(currentPosition: CLLocationCoordinate2D(latitude:tentLocation.lat.degree, longitude:tentLocation.long.degree),circleRadius: (tentLocation.radius * 1000)/100, zoom:14.3)
                        .cornerRadius(30)
                }

            }
            .padding(.top,20)
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    
                    Button(action:{}){
                        ZStack{
                            Rectangle()
                                .fill(Color.blue)
                            Text("Join")
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                            }
                            .frame(width:100,height:30)
                            .cornerRadius(20)
                        
                        }
                    }
                    .padding(.trailing,15)
                    .padding([.bottom],10)
            }
            
        }
        .frame(width:350,height: 250)
    }
}

