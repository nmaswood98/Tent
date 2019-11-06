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

struct TentView: View {
    @ObservedObject var tent = Tent()
    var body: some View {
        List {
            ForEach(tent.rows) { row in
                HStack(alignment: .center) {
                    ForEach(row.cells) { cell in
                            KFImage(URL(string: cell.imageURL)!)
                              .placeholder {
                                EmptyView()
                                }
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        
        }
    }
}

struct TentView_Previews: PreviewProvider {
    static var previews: some View {
        TentView()
    }
}
