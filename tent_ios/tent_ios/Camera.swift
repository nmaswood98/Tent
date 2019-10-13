//
//  Camera.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 10/13/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit


class Camera: NSObject, AVCapturePhotoCaptureDelegate  {
    let captureSession: AVCaptureSession
    let cameraOutput: AVCapturePhotoOutput
    let previewLayer: AVCaptureVideoPreviewLayer
    let backCamera: AVCaptureDevice?
    let deviceInput: AVCaptureDeviceInput?
    
    override init(){
        
        captureSession = AVCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        captureSession.beginConfiguration()
        captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        deviceInput = try? AVCaptureDeviceInput(device: backCamera!)
        
        cameraOutput = AVCapturePhotoOutput()
        
        super.init()

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
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
       guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let image = UIImage(data: imageData)
        UIImageWriteToSavedPhotosAlbum(image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        print("Captured Image")
        
    }
    
    func takePicture(){
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        cameraOutput.capturePhoto(with: settings, delegate: self)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if error != nil {
           print("We got an error")
        } else {
           print("Saved to the library successfully")
        }
    }

}
