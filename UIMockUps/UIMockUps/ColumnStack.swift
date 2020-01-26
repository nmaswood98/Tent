//
//  ColumnStack.swift
//  UIMockUps
//
//  Created by Nabhan Maswood on 1/26/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct ColumnStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let rowSpacing: CGFloat
    let columnSpacing: CGFloat
    let hello = 0
    let content: (Int, Int) -> Content

    var body: some View {
        HStack(spacing:columnSpacing){
            Spacer()
            ForEach(0 ..< columns) { row in
                VStack( spacing: self.rowSpacing) {
                    ForEach(0 ..< self.rows) { column in
                        self.content(column, row)
                    }
                    Spacer()
                }
            }
            Spacer()
        }
    }
}

struct ColumnStack_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            ColumnStack(rows: 4, columns: 2, rowSpacing: 30, columnSpacing: 30){_,_ in
                Rectangle().fill(Color.red).frame(height:200).cornerRadius(20)
            }
        }

    }
}



