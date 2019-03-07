//
//  AppDelegate.swift
//  Test
//
//  Created by Champ on 05/03/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        
        navigationController = UINavigationController()
        let countryDetailsViewController = CountryDetailsViewController()
        self.navigationController!.pushViewController(countryDetailsViewController, animated: false)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = navigationController
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
        
        return true
    }


}

