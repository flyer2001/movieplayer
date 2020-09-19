//
//  AppDelegate.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 15.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        ApplicationController.start()
        return true
    }

}
