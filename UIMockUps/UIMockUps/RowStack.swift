//
//  RowStack.swift
//  UIMockUps
//
//  Created by Nabhan Maswood on 1/26/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct RowStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let rowSpacing: CGFloat
    let columnSpacing: CGFloat
    let hello = 0
    let content: (Int, Int) -> Content

    var body: some View {
        VStack(spacing:rowSpacing){
            ForEach(0 ..< rows) { row in
                HStack(alignment: .top, spacing: self.columnSpacing) {
                    Spacer()
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct RowStack_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            RowStack(rows: 20, columns: 2, rowSpacing: 30, columnSpacing: 30){_,_ in
                Rectangle().fill(Color.red).frame(height:200).cornerRadius(20)
            }
        }

    }
}



