//
//  PublicTentView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/31/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct PublicTentView: View {
    @EnvironmentObject var tentConfig: TentConfig
    @EnvironmentObject var publicTents: PublicTents
    @EnvironmentObject var loadingService: LoadingViewService
    @EnvironmentObject var locationService: LocationService


    
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
                    ForEach(Array<TentData>(publicTents.tents.values).sorted(by: { (data1, data2) -> Bool in
                        return data1.timeJoined > data2.timeJoined
                    }), id:\.self){tentData in
                        TentHistoryView(name: tentData.name, code: tentData.code, tentLocation: tentData.tentLoc, expanded: true)
                    }
                }
            }
            .navigationBarTitle(Text("Public Tents").foregroundColor(Color.white), displayMode: .inline)
            .onAppear{
                self.loadingService.setLoadingMessage(text: "Joining...")
            }
        }.onAppear{
            self.publicTents.refreshTents()
        }

    }
}

