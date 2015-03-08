//
//  AppDelegate.swift
//  ParseDemo
//
//  Created by Boris on 25.01.15.
//  Copyright (c) 2015 Boris Musatov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        initParse()
        navigationBarTheme()
        
        return true
    }

    private func initParse() {
        ParseUtils.initParse()
    }
    
    private func navigationBarTheme() {
        ThemeFactory.navigationBarTheme()
    }

}

