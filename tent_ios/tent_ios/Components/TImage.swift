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
    @ObservedObject var tentImage: TentImage
    var body: some View {
        
        KFImage(URL(string: tentImage.imageURL))
            .resizable()
            .scaledToFit()
            .cornerRadius(20)
        .overlay(
            ZStack{
                VStack{
                    HStack{
                        Spacer()
                        Circle()
                            .fill(tentImage.uploaded ? Color.clear : Color.red)
                        .frame(width: 20, height: 20)
                        .padding()
                    }
                    Spacer()
                }

                RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 0.5)
            }
        )
            .sheet(isPresented: $showImageExpanded){
                ZStack{
                Color.white.edgesIgnoringSafeArea(.all)
                KFImage(URL(string: self.tentImage.imageURL))
                    .resizable()
                    .scaledToFit()
                }
        }
            .onTapGesture {
                self.showImageExpanded = true
        }
    }
}


