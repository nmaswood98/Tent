//
//  AppServices.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/22/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import Foundation
import SwiftUI


struct AppServices: ViewModifier {
    
    private static var tentConfig = TentConfig()
    private static var tentContent = 

    func init
    
    func body(content:Content) -> some View {
        content
            .environmentObject(tentConfig)
            .environmentObject(tentContent)
    }
}
