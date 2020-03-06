//
//  AppDelegate.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 10/12/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import Introspect
import GPhotos

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var config = Config()
        config.printLogs = false
        GPhotos.initialize(with: config)
        
        GMSServices.provideAPIKey("GOOGLEMAPSAPIKEY")
        FirebaseApp.configure()
        
        Auth.auth().signInAnonymously() { (authResult, error) in
          guard let user = authResult?.user else {
            print("Couldn't Authenticate")
            return
            }
          let isAnonymous = user.isAnonymous
          let uid = user.uid
         print("Authenticated \(uid) isAnonymous \(isAnonymous)")
            //should only do this once
        Firestore.firestore().collection("Users").document(uid).setData(["ID":uid,"blocked":false])
            

        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let gphotosHandled = GPhotos.continueAuthorizationFlow(with: url)
        // other app links
        return gphotosHandled
    }


}

