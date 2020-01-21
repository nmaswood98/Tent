//
//  MenuButton.swift
//  UIMockUps
//
//  Created by Nabhan Maswood on 1/17/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct MenuButton: View {
    var text: String
    var action: () -> ()
    var destination: String = ""
    var body: some View {
        
        Button(action:self.action){
            ZStack{
                Rectangle()
                    .fill(Color.green)
                    .cornerRadius(30)
                
                Text(text)
                    .foregroundColor(.white)
            }
        }

    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(text:"hi",action:{
            print("Hello")
        }).frame(height: 50)
    }
}
