//
//  InfoView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/20/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    
    @State var navigationBarTitle: String = "Tents Near You"
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    var body: some View {
        
        return ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            
            
            TabView {
                
                
                PublicTentView()
                    .tabItem {
                        Image(systemName: "1.square.fill")
                        Text("Public Tents")
                }.onAppear{
                    self.navigationBarTitle = "Tents Near You"
                }.onDisappear{
                    self.navigationBarTitle = "Tent History"
                }
                HistoryView()
                    .tabItem {
                        Image(systemName: "2.square.fill")
                        Text("Tent History")
                }
                
            }
            
            
            
            
        }.navigationBarTitle(Text(self.navigationBarTitle), displayMode: .automatic)
            .navigationBarHidden(false)
            .accentColor(Color.green)
        
        
        
        
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
