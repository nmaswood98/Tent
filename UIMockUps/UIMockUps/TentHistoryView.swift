//
//  TentHistoryView.swift
//  UIMockUps
//
//  Created by Nabhan Maswood on 1/20/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import CoreLocation

struct TentHistoryView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .cornerRadius(0)
                .frame(width:35,height: 165)
            HStack(spacing:0){
                MapView2(currentPosition: CLLocationCoordinate2D(latitude: 40.691247, longitude: -73.632684), circleRadius: 4)
                    .cornerRadius(20)
                    .frame(width:162,height:202)
                ZStack{
                    Rectangle()
                        .fill(Color.white)
                    .cornerRadius(20)
                    .frame(width:165,height: 165)
                        .overlay(VStack{
                            HStack{
                                VStack{
                                    Text("Tent: VGHD")
                                        .padding([.top,.leading], 20)
                                        .foregroundColor(.green)
                                        .font(.system(size: 23))
                                    Text("Status: Open")
                                        .font(.system(size: 15))
                                        .foregroundColor(.green)
                                        .padding([.top],15)
                                    Spacer()
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
                                Spacer()
                            }
                            Spacer()
                        })
                    
                    


                }

                
            }
            
        }

    }
}

struct TentHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.gray

        VStack(spacing:15){
            TentHistoryView().offset(x: 0, y: 56)

                     //  TentHistoryView()

                      // TentHistoryView()

        }
            Image("redtent")
            .resizable()
                .imageScale(.large)
                .edgesIgnoringSafeArea(.all)
                .opacity(0)
        }.edgesIgnoringSafeArea(.all)
    }
}
