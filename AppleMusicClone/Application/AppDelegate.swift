//
//  AppDelegate.swift
//  AppleMusicClone
//
//  Created by 민창경 on 2020/11/24.
//

import UIKit
import SnapKit
import Then
import Gedatsu

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Gedatsu.open()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

