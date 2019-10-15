//
//  ContentView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 10/12/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import UIKit
import AVFoundation

struct ContentView: View {
    let camera = Camera()
        var body: some View {
            NavigationView{
                ZStack(alignment: .center){
                    CameraView(camera: camera, color: UIColor.red)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        Text("Tent")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                        Spacer()
                        Button(action:takePicture){
                            Text("Take Picture")
                                .font(.title)
                                .foregroundColor(.green)
                        }.padding(.bottom, 50)
                        
                        NavigationLink(destination: TentView()){
                                Text("View Tent")
                                    .font(.caption)
                                    .foregroundColor(.green)
                        }.padding(.bottom,50)
                        
                    }
                }
            }.navigationBarHidden(true)
    }
    
    func takePicture(){
        camera.takePicture()
    }
}


