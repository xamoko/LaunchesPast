//
//  AppDelegate.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 20/08/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

     
        let vc = ViewController()
        self.window?.rootViewController = UINavigationController(rootViewController: vc)

     
        return true
    }
}

