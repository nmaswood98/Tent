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
    @State var expanded: Bool
    var body: some View {
        ZStack{
            MapView2(currentPosition: CLLocationCoordinate2D(latitude: 40.691247, longitude: -73.632684), circleRadius: 4)
            .cornerRadius(20)
            .onTapGesture {
                withAnimation{
                    self.expanded.toggle();
                }
            }
            
            VStack{
                HStack{
                    ZStack{
                          Rectangle()
                              .fill(Color.green)
                          Text("Tent: 1234")
                              .foregroundColor(.white)
                              .font(.system(size: 20))
                      }
                    .frame(width:120,height:30)
                      .cornerRadius(5)
                      .padding(.leading,15)
                      .padding([.top],10)
                    Spacer()
                }
                if(self.expanded){
                    Spacer()

                    HStack{
                        Spacer()
                         Button(action:{

                             
                         }){
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
                          .padding(.trailing,15)
                          .padding([.bottom],10)
                    }
                }
            }

           
        }

        .frame(width:self.expanded ? 300: 150,height:self.expanded ? 202: 100)


    }
}

struct TentHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.gray

        VStack(spacing:15){
            ZStack{
                TentHistoryView(expanded: true).padding(.leading, 160)

                TentHistoryView(expanded: false).padding(.leading, -160)

            }
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
