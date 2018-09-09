//
//  AppDelegate.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleMaps
import SwiftyUserDefaults
import Firebase
import IQKeyboardManagerSwift
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if !Defaults.hasKey(.userLoggedId) || Defaults.hasKey(.userLoggedId) == false {
            let storyboard = UIStoryboard(storyboard: .Login)
            let loginVC: LoginVC = storyboard.instantiateViewController()
            self.window!.rootViewController = loginVC
        } else {
            let storyboard = UIStoryboard(storyboard: .Main)
            let homeTB = storyboard.instantiateInitialViewController()
            self.window!.rootViewController = homeTB
        }
        
        IQKeyboardManager.sharedManager().enable = true
        
        Fabric.with([Crashlytics.self])
        GMSServices.provideAPIKey(googleApiKey)
        FirebaseApp.configure()
         return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
    }
}

