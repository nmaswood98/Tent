//
//  LoadingViewService.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/23/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI

class LoadingViewService: ObservableObject {
    @Published var showLoadingDialog: Bool = false
    @Published var loadingMessage: String = "Loading..."

    init(){
        
    }
    
    func enableLoadingDialog(){
        showLoadingDialog = true;
    }
    
    func disableLoadingDialog(){
        showLoadingDialog = false;
    }
    
    func setLoadingMessage(text: String){
        loadingMessage = text
    }
    
}

