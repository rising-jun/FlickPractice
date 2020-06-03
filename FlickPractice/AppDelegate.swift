//
//  AppDelegate.swift
//  FlickPractice
//
//  Created by 김동준 on 2020/05/18.
//  Copyright © 2020 김동준. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window  : UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = StartController()
        
        return true
    }
    // MARK: UISceneSession Lifecycle
}
