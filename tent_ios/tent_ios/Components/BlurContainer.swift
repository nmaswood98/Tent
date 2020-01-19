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

    var body: some View {
        ZStack{
            BlurView(style:.dark)
            self.container()
        }
    }
}


