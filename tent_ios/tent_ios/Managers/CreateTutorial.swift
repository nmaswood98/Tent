//
//  CreateTutorial.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 7/28/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import Foundation
import BLTNBoard

class CreateTutorial{
    let manager: BLTNItemManager
    init(){
        let firstItem = BLTNPageItem(title: "Create a Tent!")
        firstItem.descriptionText = "Tents are created from your current location with the selected radius. Only people within the radius can join the tent. There are 3 types of tents you can create, Google Photos, Private and Public."
        firstItem.actionButtonTitle = "Next"
        firstItem.alternativeButtonTitle = "Skip"
        
        let secondItem = BLTNPageItem(title: "Google Photos")
        secondItem.descriptionText = "Google Photos tents create a shared album in your Google Photos account. People can join the tent and any photos you or they capture get uploaded into the shared album."
        secondItem.actionButtonTitle = "Next"
        secondItem.alternativeButtonTitle = "Skip"
        
        let thirdItem = BLTNPageItem(title: "Private")
        thirdItem.descriptionText = "Private tents are only accesible with a code or a link. The tent gets deleted after one hour."
        thirdItem.actionButtonTitle = "Next"
        thirdItem.alternativeButtonTitle = "Skip"
        
        let fourthItem = BLTNPageItem(title: "Public")
        fourthItem.descriptionText = "Public Tents are visible to anyone within the tent radius, viewable in the 'Tents' page. Anyone can join and be able to upload images"
        fourthItem.actionButtonTitle = "Finish"
        
        self.manager = BLTNItemManager(rootItem: firstItem)
        
        let nextItem : (BLTNActionItem) -> Void  = {item in
            self.manager.displayNextItem()
        }
        
        let dismiss:(BLTNActionItem) -> Void  = {item in
            self.manager.dismissBulletin()
            UserDefaults.standard.set(true, forKey: "CreateTutorial")
        }
        
        let preventTutorial:(BLTNItem) -> Void  = {item in
            UserDefaults.standard.set(true, forKey: "CreateTutorial")
        }
        
        firstItem.next = secondItem
        secondItem.next = thirdItem
        thirdItem.next = fourthItem
        
        firstItem.actionHandler = nextItem
        secondItem.actionHandler = nextItem
        thirdItem.actionHandler = nextItem
        
        firstItem.alternativeHandler = dismiss
        secondItem.alternativeHandler = dismiss
        thirdItem.alternativeHandler = dismiss
        
        fourthItem.actionHandler = dismiss
        
        firstItem.dismissalHandler = preventTutorial
        secondItem.dismissalHandler = preventTutorial
        thirdItem.dismissalHandler = preventTutorial
        fourthItem.dismissalHandler = preventTutorial
        
        
        
    }
    
    func showItem(){
        if let controller = UIApplication.shared.windows.last?.rootViewController {
            self.manager.showBulletin(above: controller)
        }
    }
    
    func removeItem(){
        self.manager.dismissBulletin()
    }
}
