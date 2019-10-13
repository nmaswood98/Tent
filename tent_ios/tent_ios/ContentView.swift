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
    let previewLayer: AVCaptureVideoPreviewLayer
    var body: some View {
        ZStack(alignment: .center){
            CameraView(previewLayer:previewLayer, color: UIColor.red)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Welcome to")
                    .font(.title)
                    .foregroundColor(.green)
                Text("Tent")
                    .font(.largeTitle)
                    .foregroundColor(.green)
            }
        }
    }
}


