//
//  TentManagementView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/6/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct TentManagementView: View {
    @State private var code: String = ""
    var body: some View {
             VStack(alignment: .center) {
                
               Text("Join a Tent")
                   .font(.title)
                   .foregroundColor(.green)
                
                
                TextField("Code", text:$code)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
            
                
                Button(action:{}){
                    Text("Enter")
                        .font(.body)
                        .foregroundColor(.green)
                        .padding(.top,30)
                }
           }
           .padding(15)
    
    }
}


