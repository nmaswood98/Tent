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
import CameraKit_iOS

class CameraKit: NSObject, AVCapturePhotoCaptureDelegate  {
    
    let uploadManager: UploadManager
    let tentGallery: TentGallery
    let photoSession: CKFPhotoSession
    init(uploadManager: UploadManager, tentGallery: TentGallery){
        
        self.tentGallery = tentGallery
        self.uploadManager = uploadManager
        self.photoSession = CKFPhotoSession()
        self.photoSession.session.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        super.init()
        
    }
    

    
    func rotateImage(image: UIImage) -> UIImage? {
        if (image.imageOrientation == UIImage.Orientation.up ) {
            return image
        }
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        let copy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return copy
    }
    

    func takePicture(){
        DispatchQueue.global(qos: .background).async {

        self.photoSession.capture({ (image, settings) in
            DispatchQueue.main.async {

                let tentImage = TentImage(timeCreated: Date().timeIntervalSince1970, image: self.rotateImage(image: image)!)
                self.uploadManager.uploadImage(name: tentImage.id.uuidString, image: self.rotateImage(image: image)!){
                    downloadURL in
                    tentImage.changeImageURL(newURL: downloadURL)
                }
                self.tentGallery.addImage(image:tentImage)
            
            

            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            }

        }) { (error) in
            // TODO: Handle error
        }
        }
        
        //cameraOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func switchCamera(){
        self.photoSession.togglePosition()
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if error != nil {
            print("We got an error")
        } else {
            print("Saved to the library successfully")
            
        }
    }
    
}
