//
//  CameraView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 10/13/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import UIKit
import AVFoundation

struct CameraView: UIViewRepresentable {
    let color: UIColor
    let camera = Camera()
    func makeUIView(context: Context) -> UIView {
        let previewLayer = camera.previewLayer
        let nativeView = UIView(frame: .zero)
        DispatchQueue.main.async {
            previewLayer.frame = nativeView.bounds
        }
        nativeView.layer.insertSublayer(previewLayer, at: 0)
        nativeView.backgroundColor = color
        return nativeView
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<CameraView>) {
        
    }
    func setUpUIView(){
        
    }
}


