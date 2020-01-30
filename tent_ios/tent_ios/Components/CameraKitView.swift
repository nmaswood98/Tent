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
import CameraKit_iOS

struct CameraKitView: UIViewRepresentable {
    
    let cameraKit: CameraKit
    func makeUIView(context: Context) -> CKFPreviewView {
        
        let previewView = CKFPreviewView(frame: CGRect(x: 0, y: 0, width: 100, height: 600 ))
            
        previewView.session = self.cameraKit.photoSession
        previewView.previewLayer?.videoGravity = .resizeAspectFill
        previewView.autorotate = true
        return previewView
    }
    func updateUIView(_ uiView: CKFPreviewView, context: UIViewRepresentableContext<CameraKitView>) {
        
    }
    func setUpUIView(){
        
    }
}
