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
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    var body: some View {
        
        
        
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack(spacing:30){
                    ForEach(Array<TentData>(tentConfig.tentHistory.values), id:\.self){tentData in
                        TentHistoryView(code: tentData.code, tentLocation: tentData.tentLoc, expanded: true)
                    }
                }
            }
            .navigationBarTitle(Text("Tent History").foregroundColor(Color.black), displayMode: .inline)
            .onAppear{
                self.loadingService.setLoadingMessage(text: "Joining...")
            }
        }

    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
