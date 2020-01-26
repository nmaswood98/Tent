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

struct GalleryView: View {
    @EnvironmentObject var tentGallery: TentGallery
    
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
        ScrollView{
        HStack(spacing:30.0){
            Spacer()
            ForEach(tentGallery.columns) { columns in
                VStack( spacing: 30.0) {
                    ForEach(columns.images) { item in
                        TImage(tentImage: item)
                            .frame(height:300)
                    }
                    Spacer()
                }
            }
            Spacer()
        }
    }
    }
    }
    
}


