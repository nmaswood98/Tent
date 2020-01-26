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
    var body: some View {
        VStack{
 
            ScrollView{
                            ZStack{
                    MapView2(centerPosition: CLLocationCoordinate2D(latitude: 40.712776, longitude: -74.005974), circleRadius: 1)
                        .edgesIgnoringSafeArea(.all)
                        .frame(height:400)
                                
                                     ZStack{
                          Rectangle()
                            .fill(Color.green)
                          Text("Tent: 1234")
                              .foregroundColor(.white)
                              .font(.system(size: 30))
                                       
                      }
                    .frame(width:160,height:40)
                      .cornerRadius(5)
                                 .offset(x: 0, y: -25)
                }
                
                if(contentArr.count > 0){
                    ZStack{
                        Color.white
                    ColumnStack(rows: contentArr.count, columns: contentArr[0].count, rowSpacing: 30, columnSpacing: 30){row,col in
                        ZStack{
                            Rectangle().fill(Color.blue).frame(height:self.heightArr[row][col]).cornerRadius(20)
                            Text(self.contentArr[row][col])
                        }
                    }.padding(.top,30)
                    }.cornerRadius(30)
                    .offset(x: 0, y: -100)
                }
            }.edgesIgnoringSafeArea(.all)
            Spacer()
        }

    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView().statusBar(hidden: true)
    }
}
