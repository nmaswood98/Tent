//
//  CustomScrollView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 7/23/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import BLTNBoard

struct CustomScrollView<Content: View>: UIViewRepresentable{

    let numberOfItems: Int
    let content: () -> Content
    var hostingController: UIHostingController<Content>
    
    let refreshControl = UIRefreshControl()
    
     init(numberOfItems: Int, content: @escaping () -> Content){
        self.numberOfItems = numberOfItems
        self.content = content
        self.hostingController = UIHostingController(rootView: self.content())
    }

    
    func makeCoordinator() -> Coordinator {
        return CustomScrollView.Coordinator(refreshControl: refreshControl)
    }

    
     func makeUIView(context: Context) ->  UIScrollView {
        
        let view = UIScrollView()
        view.refreshControl = refreshControl
        refreshControl.addTarget(context.coordinator, action: #selector(context.coordinator.update), for: .valueChanged)
        
        self.hostingController.view.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: numberOfItems * 325)
        
        view.addSubview(self.hostingController.view)
        view.contentSize = CGSize(width: 100, height: numberOfItems * 325)
        view.delegate = context.coordinator
        

        
        
        return view
    }
    
    //Update the size of the scrollview when the view updates.
    func updateUIView(_ uiView:  UIScrollView, context: Context) {
        self.hostingController.view.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: numberOfItems * 325)
        uiView.contentSize = CGSize(width: 100, height: numberOfItems * 325)
        uiView.frame = CGRect(x: 0, y: 0, width: uiView.frame.width, height: uiView.frame.height)

    }
    
    // Handles refreshcontrol and notificaitons related to the notificaiton contro
    class Coordinator: NSObject, UIScrollViewDelegate {
        let refreshControl: UIRefreshControl
        
        init(refreshControl: UIRefreshControl){
            self.refreshControl = refreshControl
            super.init()
            NotificationCenter.default.addObserver(self, selector: #selector(endRefresh), name: Notification.Name("GPRetrievedMediaItems"), object: nil)
        }
        
        @objc func endRefresh(){
            if(self.refreshControl.isRefreshing){
                self.refreshControl.endRefreshing()
            }
        }
        
        @objc func update(){
            print("Refreshed the gallery page")
            NotificationCenter.default.post(name:Notification.Name("ReloadGooglePhotosTent"), object: nil)
            
        }
        
        @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)){
                print("REACHED THE BOTTOM")
            }
        }
    }
    

}
