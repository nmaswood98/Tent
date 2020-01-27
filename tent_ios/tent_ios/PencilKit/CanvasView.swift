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
        canvas.canvasView = canvasView
        return canvasView;
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: UIViewRepresentableContext<CanvasView>) {
    }
}

