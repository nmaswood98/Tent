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
    @State var expand: Bool = false
    @State var expandInstant: Bool = false
    
    var body: some View {
        
                
            ZStack{
                Rectangle()
                    .fill(Color.red)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    
                    Spacer()


                    
                    if (!open){
                        Text("Tent: 1234")
                            .foregroundColor(.green)
                    }

                    
                   
                    

                    


                    ZStack{
                        Rectangle()
                            .fill(Color.black)
                            .cornerRadius(30)
                        
                        VStack(){
                            
                            if(self.expand){
                                Spacer()

                                HStack(spacing:10){
                                    Spacer()
                                    
                                    MenuButton(text:"Tents", action:{print("Tents")})
                                    MenuButton(text:"Join", action:{print("Join")})
                                    MenuButton(text:"Create", action:{print("Create")})

                                    Spacer()
                                }
                                .frame( height: 60)
                                .offset(x:0,y:expand ? 0 : 200)
                                .transition(.offset(x: 0, y: 200))
                                .transition(.scale(scale: 0, anchor: .bottom))

                            }
                            

                            Spacer()


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
                                      .frame(width: 75,height:75)
                                      .padding(.bottom, 10)

                                  }
                                  

                                  
                                  Button(action:{

                                    withAnimation{
                                        self.expand.toggle()
                                    }

                                    
                                  }){
                                      Image("tent")
                                          .resizable()
                                          .frame(width: 50, height: 50)
                                          .padding(.top, 5)
                                  }

                                  

                                      
                              }
                            .padding()

                        }
                        
  
                        
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame( height: expand ? 200 : 125)
                    .animation(.spring())
                    
                    
                    
                    
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
