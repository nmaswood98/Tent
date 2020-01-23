//
//  InfoView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/20/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var tentConfig: TentConfig
    @EnvironmentObject var loadingService: LoadingViewService
    
    var body: some View {
        TabView {
            ScrollView{
            VStack{
            ForEach(Array<TentData>(tentConfig.tentHistory.values), id:\.self){tentData in
                TentHistoryView(code: tentData.code, tentLocation: tentData.tentLoc)
            }
            }
        }
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("First")
                }
            Text("Another Tab")
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Second")
                }
            Text("The Last Tab")
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Third")
                }
        }
        .font(.headline)
        .onAppear{
            self.loadingService.setLoadingMessage(text: "Joining...")
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
