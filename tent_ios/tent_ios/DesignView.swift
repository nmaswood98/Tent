//
//  DesignView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/17/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct DesignView: View {
    let camera: Camera
    @EnvironmentObject var tentConfig: TentConfig
    var body: some View {
        ZStack
            {
                CameraView(camera: camera, color: UIColor.red)
                    .edgesIgnoringSafeArea(.all)
                    .environmentObject(tentConfig)
                VStack{
                    
                    Spacer()
                    Text("Tent: 1234")
                        .foregroundColor(.green)
                    ZStack{
                        BlurView(style: .dark)
                        
                        HStack(spacing:60){
                            Rectangle()
                                .fill(Color.red)
                                .opacity(0.5)
                                .frame(width: 45, height: 45)
                            
                            Circle()
                                .fill(Color.green)
                                .opacity(0.5)
                                .frame(width: 75)
                                .padding(.bottom, 10)
                            
                            Rectangle()
                                .fill(Color.blue)
                                .opacity(0.5)
                                .frame(width: 45, height: 45)
                        }
                        
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame( height: 125, alignment: .bottom)
                    
                    
                    
                }
                .edgesIgnoringSafeArea(.all)
                
                
                
                
        }
    }
}


