//
//  ContentView.swift
//  UIMockUps
//
//  Created by Nabhan Maswood on 11/17/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var open: Bool = false
    
    var body: some View {
        
                
            ZStack{
                Rectangle()
                    .fill(Color.red)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    
                    Spacer()

                        VStack{
                            ZStack{
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 300, height: 100)
                                    .cornerRadius(20)
                                
                                HStack(spacing:27){
                                    Image("redtent")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .padding(.bottom, 3)
                                    
                                    Text("   Join a Tent  ")
                                        .font(.custom("text", size: 20))
                                }
                            }
                            .padding(10)
                            
                            
                            
                            ZStack{
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 300, height: 100)
                                    .cornerRadius(20)
                                
                                HStack(spacing:30){
                                    Image("bluetent")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .padding(.bottom, 3)
                                    
                                    Text("Create a Tent")
                                        .font(.custom("text", size: 20))
                                }
                            }
                            .padding(10)
                        }
                        .offset(y:open ? 0 : UIScreen.main.bounds.height)
                        .animation(.default)
                    
                    if (!open){
                        Text("Tent: 1234")
                            .foregroundColor(.green)
                    }

                    
                   
                    

                    


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
                                        .opacity(1)
                                    Circle()
                                        .fill(Color.white)
                                        .opacity(1)
                                        .frame(width:65)

                                }
                                .frame(width: 75)
                                .padding(.bottom, 10)

                            }
                            

                            
                            Button(action:{
                                self.open.toggle()
                            }){
                                Image("tent")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding(.top, 5)
                            }

                            

                                
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
