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
    
    var body: some View {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.green]
        
        return ZStack{
            Color.white.edgesIgnoringSafeArea(.all)

            TabView {
                
                PublicTentView()
                    .tabItem {
                        Image(systemName: "1.square.fill")
                        Text("Public Tents")
                }.onAppear{
                    self.navigationBarTitle = "Tents Near You"
                }
                HistoryView()
                    .tabItem {
                        Image(systemName: "2.square.fill")
                        Text("Tent History")
                }.onAppear{
                    self.navigationBarTitle = "Tent History"
                }

            }
        }.navigationBarTitle(Text(self.navigationBarTitle).foregroundColor(Color.green))
            .navigationBarHidden(false)
           .accentColor(Color.green)


    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
