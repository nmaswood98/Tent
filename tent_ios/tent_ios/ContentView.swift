//
//  ContentView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 10/12/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import UIKit
import AVFoundation

struct ContentView: View {
        var body: some View {
        ZStack(alignment: .center){
            CameraView(color: UIColor.red)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Tent")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                Spacer()
            }
        }
    }
}


