//
//  GalleryView.swift
//  UIMockUps
//
//  Created by Nabhan Maswood on 1/25/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import CoreLocation

struct GalleryView: View {
    var contentArr: [[String]] = [["Hello","My"],["Name","Nabhan"]]
    var heightArr: [[CGFloat]] = [[200,100],[200,200]]
    @State var cameraMode: Bool = true
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    Button(action:{
                        print("Hi")
                    }){
                        ZStack{
                            Rectangle()
                                .fill(self.cameraMode ? Color.green : Color.red)
                            Text(self.cameraMode ? "Camera" : "Draw")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                        }
                        .frame(width:80,height:30)
                        .cornerRadius(5)
                    }
                    .padding(.top,50)
                    .padding(.trailing,10)
                }
                Spacer()
            }.edgesIgnoringSafeArea(.all)
        }
        
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView().statusBar(hidden: true)
    }
}
