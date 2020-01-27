//
//  Canvas.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/26/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import Foundation
import PencilKit
import AVFoundation

class Canvas: NSObject,AVCapturePhotoCaptureDelegate {
    var canvasView: PKCanvasView?
    
    let uploadManager: UploadManager
    let tentGallery: TentGallery
    
    init(uploadManager: UploadManager, tentGallery: TentGallery){
        
        self.tentGallery = tentGallery
        self.uploadManager = uploadManager
        
        super.init()
        
    }
    
    func takePicture(){
        if let canvas = canvasView{
            let image = canvas.drawing.image(from:canvas.frame, scale: 1)
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

            let tentImage = TentImage(timeCreated: Date().timeIntervalSince1970, image: image)
            uploadManager.uploadImage(name: tentImage.id.uuidString, image: image){
                downloadURL in
                tentImage.changeImageURL(newURL: downloadURL)
            }
            self.tentGallery.addImage(image:tentImage)
        }

    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if error != nil {
            print("We got an error")
        } else {
            print("Saved to the library successfully")
            
        }
    }
}
