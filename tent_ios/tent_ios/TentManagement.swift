//
//  TentManagement.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/6/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import Foundation
import FirebaseFunctions
import SwiftUI

class TentManagement : ObservableObject {
    @Published var showAlert: Bool = false
    
    lazy var functions = Functions.functions()

    init(){
    }
    
    func submitCode(value: String, config: TentConfig, displayAlert: Binding<Bool>){
        print("Submitting Code")
        functions.httpsCallable("JoinTent").call(["code": value]) { (result, error) in
            print("GOt it")
          if let error = error as NSError? {
            print(error)
            config.code = ""
          }
            if let text = result?.data as? String {
                
                if(text == "False"){
                    displayAlert.wrappedValue = true
                    config.code = ""
                    config.name = "DefaultTent"
                }
                else {
                    config.code =  text
                    config.name = config.code
                }
                
          }
        }
    }
    
}
