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
    var toolPicker: PKToolPicker?
    
    let uploadQueue: ImageUploadQueue
    let tentGallery: TentGallery
    
    init(uploadQueue: ImageUploadQueue, tentGallery: TentGallery){
        
        self.tentGallery = tentGallery
        self.uploadQueue = uploadQueue
        
        super.init()
        
    }
    
    func takePicture(){
        if let canvas = canvasView{
            let image = canvas.drawing.image(from:canvas.frame, scale: 1)
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

            let tentImage = TentImage(timeCreated: Date().timeIntervalSince1970, image: image)
            // Uploads image to tent
            self.uploadQueue.addImage(image: image, tentImage: tentImage)
            self.tentGallery.addImage(image:tentImage)
            
        }

    }
    
    func toggleTools() -> Bool{
        if let tPicker = toolPicker, let canvas = canvasView{
            if(tPicker.isVisible == false){
                canvas.becomeFirstResponder()
            }
            tPicker.setVisible(!tPicker.isVisible, forFirstResponder: canvas)
            return tPicker.isVisible
        }
        return false
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if error != nil {
            print("We got an error")
        } else {
            print("Saved to the library successfully")
            
        }
    }
}
