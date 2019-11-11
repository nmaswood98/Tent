//
//  Tent.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 10/15/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Kingfisher

struct Row: Identifiable {
    let id = UUID()
    var cells: [Cell]
}

class TentContent: ObservableObject{
    @Published var rows:[Row] = []
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
                            self.addEntry(entry: url as! String)
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
    
    func addRow(entry1:String,entry2:String){
        rows.append(Row(cells: [Cell(imageURL: entry1), Cell(imageURL: entry2)]))
    }
    
    func addEntry(entry:String){
        
        let isCached = ImageCache.default.isCached(forKey: entry)
        if (isCached) {
            self.addImageToRow(entry:entry)
            return
        }
        
        guard let url = URL.init(string: entry) else {
            return
        }
        
        let resource = ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(_):
                print("Got Image Downloaded")
                self.addImageToRow(entry:entry)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    func addImageToRow(entry:String){
        if rows.count >= 1 {
            if rows[0].cells.count == 1{
                rows[0].cells.insert(Cell(imageURL: entry), at:0 )
            }
            else{
                rows.insert(Row(cells: [Cell(imageURL: entry)]), at: 0)
            }
        }
        else{
            rows.insert(Row(cells: [Cell(imageURL: entry)]), at: 0)
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
        
        rows = []
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
                            self.addEntry(entry: url as! String)
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

struct Cell: Identifiable {
    let id = UUID()
    var imageURL: String
}
