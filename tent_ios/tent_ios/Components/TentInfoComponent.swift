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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var tentManagment: TentManagement
    @EnvironmentObject var tentConfig: TentConfig
    @EnvironmentObject var loadingService: LoadingViewService
    var code: String
    var tentLocation: TentLocation
    @State var expanded: Bool

    var body: some View {
        ZStack{
            MapView(currentPosition: self.tentLocation.getCLLocationCoordinate2D() ,circleRadius: (tentLocation.radius * 1000)/100, zoom:14.3)
                .cornerRadius(30)
            .onTapGesture {
                withAnimation{
                  //  self.expanded.toggle();
                }
            }
            
            VStack{
                HStack{
                    ZStack{
                          Rectangle()
                              .fill(Color.green)
                          Text("Tent: " + code)
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
                            self.loadingService.enableLoadingDialog()
                            
                            self.tentManagment.submitCode(value: self.code, location: self.tentLocation.getCLLocationCoordinate2D(), config: self.tentConfig, completion: {value in
                                self.loadingService.disableLoadingDialog()
                                self.presentationMode.wrappedValue.dismiss()
                            })
                             
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

        .frame(width:self.expanded ? 350: 150,height:self.expanded ? 202: 100)


    }
}

