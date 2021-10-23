//
//  AppDelegate.swift
//  UKiOSTest
//
//  Created by Paweł Sporysz on 15.09.2016.
//  Copyright © 2016 Paweł Sporysz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var startCoordinator: StartCoordinator?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        startCoordinator = StartCoordinator()
        startCoordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = startCoordinator?.rootViewController
        window?.makeKeyAndVisible()
    }
}

