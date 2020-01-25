//
//  Tentimage.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/25/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import Foundation

struct TentImage: Identifiable{
    let id = UUID()
    let timeCreated: TimeInterval
    var imageURL: String
}
