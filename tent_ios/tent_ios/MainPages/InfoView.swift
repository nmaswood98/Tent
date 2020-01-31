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
                    Spacer().frame(height:1)
                    ForEach(Array<TentData>(tentConfig.tentHistory.values).sorted(by: { (data1, data2) -> Bool in
                        return data1.timeJoined > data2.timeJoined
                    }), id:\.self){tentData in
                        TentHistoryView(name: tentData.name, code: tentData.code, tentLocation: tentData.tentLoc, expanded: true)
                    }
                }
            }
            .navigationBarTitle(Text("Tent History").foregroundColor(Color.white), displayMode: .inline)
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
