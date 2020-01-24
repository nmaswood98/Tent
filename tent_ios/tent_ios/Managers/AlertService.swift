//
//  AlertService.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/24/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import Foundation
import SwiftUI

class AlertService: ObservableObject{
    @Published var showAlert: Bool = false
    var title: String = ""
    var message: String = ""
    var buttonText: String = ""
    
    init(){
    }
    
    
    func sendAlert(title:String, message:String, buttonText: String){
        self.title = title
        self.message = message
        self.buttonText = buttonText
        self.showAlert = true
    }
       
    
}
