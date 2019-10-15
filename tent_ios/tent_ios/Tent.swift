//
//  Tent.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 10/15/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import Foundation
import SwiftUI

struct Row: Identifiable {
    let id = UUID()
    let cells: [Cell]
}

class Tent{
    var rows:[Row] = []
    init(){
        addRow(entry1: "https://i.imgur.com/nYcPFMm.jpg", entry2: "https://i.imgur.com/nYcPFMm.jpg")
        addRow(entry1: "https://i.imgur.com/nYcPFMm.jpg", entry2: "https://i.imgur.com/nYcPFMm.jpg")
        addRow(entry1: "https://i.imgur.com/nYcPFMm.jpg", entry2: "https://i.imgur.com/nYcPFMm.jpg")
    }
    
    func addRow(entry1:String,entry2:String){
        rows.append(Row(cells: [Cell(imageURL: entry1), Cell(imageURL: entry2)]))
    }
}

struct Cell: Identifiable {
    let id = UUID()
    let imageURL: String
}
