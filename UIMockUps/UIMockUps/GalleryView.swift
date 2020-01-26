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
            HStack{
                Text("Tent 1234").foregroundColor(.green).font(.system(size: 25))
                Spacer()
            }.padding(.leading,30)
                .padding(.top,50)
            ScrollView{

                if(contentArr.count > 0){
                    ZStack{
                        Color.white
                    ColumnStack(rows: contentArr.count, columns: contentArr[0].count, rowSpacing: 30, columnSpacing: 30){row,col in
                        ZStack{
                            Rectangle().fill(Color.blue).frame(height:self.heightArr[row][col]).cornerRadius(20)
                            Text(self.contentArr[row][col])
                        }
                    }.padding(.top,20)
                    }.cornerRadius(30)
                }
            }
            Spacer()
        }

    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView().statusBar(hidden: true)
    }
}
