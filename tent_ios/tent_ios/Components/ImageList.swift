//
//  ImageList.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 7/24/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct ImageList: View {
     @EnvironmentObject var tentGallery: TentGallery
    var body: some View {
        HStack(){
            Spacer()
            ForEach(self.tentGallery.columns) { columns in
                VStack() {
                    ForEach(columns.images) { item in
                        TImage(tentImage: item)
                    }
                    Spacer()
                }
            }
            Spacer()
        }
    }
}


