//
//  PublicTents.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/31/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import Foundation
import FirebaseFunctions
import SwiftUI
import CoreLocation
import FirebaseFirestore


class PublicTents: ObservableObject{
    @Published var tents: [String:TentData] = [:]
    
    
    let db = Firestore.firestore()
    var listner: ListenerRegistration?
    init(){
        self.refreshTents()
    }
    
    
    
    func refreshTents(){
        
         db.collection("PublicTents").limit(to: 20).getDocuments()  { querySnapshot, err in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(err!)")
                return
            }
            self.tents = [:]
            snapshot.documentChanges.forEach { diff in
                print("changes")
                if (diff.type == .added) {
                    print("\(diff.document.documentID) => \(diff.document.data())")
                    if let name = diff.document.data()["name"] as? String, let code = diff.document.data()["code"] as? String, let loc = diff.document.data()["Location"] as? [String: Double] {
                        let tentLoc = TentLocation(lat: loc["lat"], long: loc["long"], radius: loc["radius"])
                        let tentData = TentData(id: diff.document.documentID, code: code, name: name, type: "public", tentLoc: tentLoc, timeJoined: Date().timeIntervalSince1970)
                        self.tents[diff.document.documentID] = tentData
                        print(self.tents)

                        
                    }
                }
                if (diff.type == .modified) {
                    print("Modified city: \(diff.document.data())")
                }
                if (diff.type == .removed) {
                    print("Removed city: \(diff.document.data())")
                }
            }
            
        }
        
    }
}
