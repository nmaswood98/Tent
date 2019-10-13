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
    let previewLayer: AVCaptureVideoPreviewLayer
    let color: UIColor
    func makeUIView(context: Context) -> UIView {
        var nativeView = UIView(frame: .zero)
        DispatchQueue.main.async {
            self.previewLayer.frame = nativeView.bounds
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


