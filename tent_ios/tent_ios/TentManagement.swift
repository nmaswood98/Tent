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

class TentManagement {
    lazy var functions = Functions.functions()

    init(){
        
    }
    
    func submitCode(value: String){
        print("Submitting Code")
        functions.httpsCallable("JoinTent").call(["code": value]) { (result, error) in
            print("GOt it")
          if let error = error as NSError? {
            print(error)
          }
            if let text = result?.data {
            print(text)
          }
        }
    }
    
}
