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
    var body: some View {
        ZStack{
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 4)
            VStack{
                HStack{
                    Text("Tent: 1234")
                        .foregroundColor(.black)
                        .font(.system(size: 25))
                    Spacer()
                }
                .padding(.leading,20)
                .padding(.bottom,-5)
    
                
                ZStack{
                    MapView(currentPosition: CLLocationCoordinate2D(latitude:0, longitude:0),circleRadius: 0)
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

struct TentHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.gray
        VStack(spacing:15){
            TentHistoryView()
            

        }
        }
    }
}
