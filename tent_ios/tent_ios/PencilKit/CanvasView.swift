//
//  CanvasView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/26/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    
    let canvas: Canvas
    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView();
        canvasView.backgroundColor = UIColor.white
        canvasView.tool = PKInkingTool(.pen, color: UIColor.blue)
        canvasView.allowsFingerDrawing = true
        canvas.canvasView = canvasView
        
        if let window = UIApplication.shared.windows.last, let toolPicker = PKToolPicker.shared(for: window) {
            toolPicker.setVisible(false, forFirstResponder: canvasView)
            toolPicker.selectedTool = PKInkingTool(.pen, color: UIColor.blue)
            toolPicker.addObserver(canvasView)
            window.frame(forAlignmentRect: CGRect(x: 100, y: 1, width: 100, height: 100))
            canvasView.becomeFirstResponder()
            
            canvas.toolPicker = toolPicker
        }
        
        
        
        return canvasView;
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: UIViewRepresentableContext<CanvasView>) {
        
        
        
        
        
    }
}

