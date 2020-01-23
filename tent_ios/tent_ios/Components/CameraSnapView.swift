//
//  CameraSnapView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/9/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct CameraSnapView: View {
    @Binding var shouldFlash: Bool
    var body: some View {
        
        ZStack{
            
            if(self.shouldFlash){
                Rectangle()
                    .fill(Color.black)
                    .edgesIgnoringSafeArea(.all)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.topLeading)
                    .opacity(1)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
                            self.shouldFlash  = false
                        }
                }
            }
            
        }
        
    }
}

