//
//  OnboardingManager.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 7/28/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import Foundation
import BLTNBoard

class OnboardingManager {
    let manager: BLTNItemManager
    init(tentProfile: TentProfile){
        
        let firstItem = BLTNPageItem(title: "Welcome to Tent!")
        firstItem.descriptionText = "Tent allows you to easily share images and drawings with people near you. Just send them a code or give them a link"
        firstItem.actionButtonTitle = "Next"
        firstItem.requiresCloseButton = false
        firstItem.isDismissable = false
        
        let secondItem = BLTNPageItem(title: "Authorize Google Photos")
        
        secondItem.descriptionText = "Tent connects with Google Photos to create albums and add images."
        secondItem.actionButtonTitle = "Log In"
        secondItem.alternativeButtonTitle = "Skip"
        secondItem.requiresCloseButton = false
        secondItem.isDismissable = false
        
        firstItem.next = secondItem
        
        
        let googlePhotosSkip = BLTNPageItem(title: "Are you sure?")
        
        googlePhotosSkip.descriptionText = "Without linking your google photos account you cannot create or join tents that use Google Photos."
        googlePhotosSkip.actionButtonTitle = "Log In"
        googlePhotosSkip.alternativeButtonTitle = "Skip"
        googlePhotosSkip.requiresCloseButton = false
        googlePhotosSkip.isDismissable = false
        
        
        let completeItem = BLTNPageItem(title: "Setup Complete")
        
        completeItem.descriptionText = "Tent is now ready to use."
        completeItem.actionButtonTitle = "Get Started"
        completeItem.requiresCloseButton = false
        completeItem.isDismissable = false
        
        
        
        self.manager = BLTNItemManager(rootItem: firstItem)
        
        firstItem.actionHandler = { item in
            
            self.manager.displayNextItem()
        }
        
        let googlePhotosLogInHandler : (BLTNActionItem) -> Void = { item in
            self.manager.displayActivityIndicator()
            tentProfile.logIn(){status in
                self.manager.hideActivityIndicator()
                if(status){
                    self.manager.displayNextItem()
                }
            }
        }
        
        secondItem.next = completeItem
        secondItem.actionHandler = googlePhotosLogInHandler
        secondItem.alternativeHandler = { item in
            secondItem.next = googlePhotosSkip
            self.manager.displayNextItem()
        }
        
        googlePhotosSkip.next = completeItem
        googlePhotosSkip.actionHandler = googlePhotosLogInHandler
        googlePhotosSkip.alternativeHandler = { item in
            self.manager.displayNextItem()
        }
        
        completeItem.actionHandler = { item in
            UserDefaults.standard.set(true, forKey: "CompletedOnboarding")
            self.manager.dismissBulletin()
        }
            
        
        
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
