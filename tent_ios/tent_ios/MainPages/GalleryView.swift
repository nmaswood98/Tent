//
//  TentView.swift
//  tent_ios
//
//  where you view the files in a tent
//  Created by Nabhan Maswood on 10/15/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import BLTNBoard

struct GalleryView: View {
    @EnvironmentObject var tentGallery: TentGallery
    @EnvironmentObject var tentConfig: TentConfig
    
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Text("Tent: " + tentConfig.code).foregroundColor(.green).font(.system(size: 25))
                    Spacer()
                    ZStack{
                        Rectangle()
                            .fill(Color.green)
                            .cornerRadius(5)
                            

                        Text("Manage")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                    }
                    .frame(width:60,height:20)
                    .padding(.trailing, 20)
                    .padding(.top,2)
                    
                }.padding(.leading,30)
                
                CustomScrollView(numberOfItems: self.tentGallery.columns[0].images.count){
                    ImageList().environmentObject(self.tentGallery)
                }
                Spacer()
            }

                
        }
        .navigationBarItems(trailing:
            NavigationLink(destination: ProfileView()){
                Image(systemName: "person.circle")
                    .foregroundColor(.green)
                    .font(.system(size: 35))
                    .frame(width: 35, height: 35)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, 10)
    )

    }
    
}


