//
//  ContentView.swift
//  UIMockUps
//
//  Created by Nabhan Maswood on 11/17/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
                
            ZStack{
                Rectangle()
                    .fill(Color.red)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    
                    Spacer()
                    Text("Tent: 1234")
                        .foregroundColor(.green)
                    ZStack{
                        Rectangle()
                            .fill(Color.black)
                        
                        HStack(spacing:60){
                            Image("gallery")
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            Button(action:{print("Took Picture")}){
                                ZStack{
                                    Circle()
                                        .fill(Color.gray)
                                        .opacity(0.5)
                                    Circle()
                                        .fill(Color.white)
                                        .opacity(1)
                                        .frame(width:60)

                                }
                                .frame(width: 75)
                                .padding(.bottom, 10)

                            }
                            
                            Image("tent")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.top, 5)

                            

                                
                        }
                        
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame( height: 125, alignment: .bottom)
                    
                    
                    
                }
                .edgesIgnoringSafeArea(.all)
                
                
                
                
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
