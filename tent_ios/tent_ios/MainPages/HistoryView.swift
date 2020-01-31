//
//  HistoryView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/31/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var tentConfig: TentConfig
    @EnvironmentObject var loadingService: LoadingViewService
    
    init() {
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

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
