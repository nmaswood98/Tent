//
//  TentGallery.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 1/25/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import Foundation
import SwiftUI
import Kingfisher
import FirebaseFirestore

class TentGallery: ObservableObject{
    var imagesToDisplay: [TentImage] = [] // All images
    var imageList: [TentImage] = [] // All images including ones that are not downloaded yet
    
    let db = Firestore.firestore()
    var tentName: String
    var tentConfig: TentConfig
    var listner: ListenerRegistration?

    
    init(tentConfig: TentConfig){
        self.tentConfig = tentConfig
        tentName = tentConfig.name
        

        self.listner = db.collection("Tents").document(tentName).collection("Images").addSnapshotListener { querySnapshot, err in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(err!)")
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                print("changes")
                if (diff.type == .added) {
                    print("\(diff.document.documentID) => \(diff.document.data())")
                    if let url = diff.document.data()["URL"] {
                        self.addImage(image: TentImage(timeCreated: Date().timeIntervalSince1970, imageURL: url as! String ))
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
    
    func updateTent(){
        print("Updating Tent")
        guard listner != nil else {
            return
        }
        
        if(tentConfig.name == tentName){
            return
        }
        
        //rows = []
        tentName = tentConfig.name
        
        listner!.remove()
        
        self.listner = db.collection("Tents").document(tentName).collection("Images").addSnapshotListener { querySnapshot, err in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(err!)")
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                print("changes")
                if (diff.type == .added) {
                    print("\(diff.document.documentID) => \(diff.document.data())")
                    if let url = diff.document.data()["URL"] {
                        self.addImage(image: TentImage(timeCreated: Date().timeIntervalSince1970, imageURL: url as! String ))
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
    
    func addImage(image: TentImage){
        imageList.insert(image, at: 0)
    }

}

