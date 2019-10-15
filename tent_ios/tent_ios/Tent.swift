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

struct Row: Identifiable {
    let id = UUID()
    var cells: [Cell]
}

class Tent{
    var rows:[Row] = []
    let db = Firestore.firestore()
    let tentName = "DefaultTent"

    init(){
        
        
        db.collection("Tents").document(tentName).collection("Images").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    if let url = document.data()["URL"] {
                        self.addEntry(entry: url as! String)
                    }                }
            }
        }
        
        
        
        db.collection("Tents").document(tentName).collection("Images").addSnapshotListener { querySnapshot, err in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(err!)")
                return
            }
            
            snapshot.documentChanges.forEach { diff in
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
}

struct Cell: Identifiable {
    let id = UUID()
    var imageURL: String
}
