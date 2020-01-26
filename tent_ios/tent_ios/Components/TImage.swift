//
//  ImageView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/25/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct TImage: View {
    @State var showImageExpanded = false
    var tentImage: TentImage
    var body: some View {
        
        KFImage(URL(string: tentImage.imageURL))
            .resizable()
            .scaledToFit()
            .cornerRadius(20)
            .sheet(isPresented: $showImageExpanded){
                KFImage(URL(string: self.tentImage.imageURL))
                    .resizable()
                    .scaledToFit()
        }
            .onTapGesture {
                self.showImageExpanded = true
        }
    }
}


