//
//  BlurContainer.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/19/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct BlurContainer<Container: View>: View {
    var container: () -> Container
    var backTap: () -> ()
    var body: some View {
        ZStack{
            BlurView(style:.light)
            VStack{
                HStack{
                    Button(action:self.backTap){
                        Text("Back")
                            .foregroundColor(.green)
                            .font(.system(size: 20))
                    }
                    .padding(.top,30)
                    .padding(.leading,20)
                    Spacer()
                }
                Spacer()
            }
            self.container()
        }
    }
}


