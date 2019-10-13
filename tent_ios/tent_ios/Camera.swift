//
//  Camera.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 10/13/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import Foundation
import AVFoundation


class Camera {
    let captureSession: AVCaptureSession
    let cameraOutput: AVCapturePhotoOutput
    let previewLayer: AVCaptureVideoPreviewLayer
    let backCamera: AVCaptureDevice?
    let deviceInput: AVCaptureDeviceInput?
    
    init(){
        captureSession = AVCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        captureSession.beginConfiguration()
        captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        deviceInput = try? AVCaptureDeviceInput(device: backCamera!)
        
        cameraOutput = AVCapturePhotoOutput()

        guard deviceInput != nil else { return }
        
        
        setUpInputAndOutputs(input: deviceInput!, ouput: cameraOutput)
        
        previewLayer.connection?.videoOrientation = .portrait
        previewLayer.videoGravity = .resizeAspectFill

        captureSession.commitConfiguration()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
            print(">>> Capture Session Starting")
        }
        
        print(">>> Created Camera")
    }
    
    func setUpInputAndOutputs(input: AVCaptureDeviceInput, ouput: AVCapturePhotoOutput){
        if captureSession.canAddInput(input) && captureSession.canAddOutput(ouput) {
            captureSession.addInput(input)
            captureSession.addOutput(ouput)
        }
    }
}
