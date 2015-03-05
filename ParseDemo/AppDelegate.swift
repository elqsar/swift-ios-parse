//
//  AppDelegate.swift
//  ParseDemo
//
//  Created by Boris on 25.01.15.
//  Copyright (c) 2015 Boris Musatov. All rights reserved.
//

import UIKit
import Parse

struct Config {
    static let APP_ID = "application_id"
    static let CLIENT_ID = "client_id"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        initParse()
        navigationBarTheme()
        
        return true
    }

    private func initParse() {
        if let path = NSBundle.mainBundle().pathForResource("AppConfig", ofType: "plist") {
            if let config = NSDictionary(contentsOfFile: path) as? Dictionary<String, String> {
                Parse.enableLocalDatastore()
                Parse.setApplicationId(config[Config.APP_ID], clientKey: config[Config.CLIENT_ID])
            }
        }
    }
    
    private func navigationBarTheme() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 223/255, green: 105/255, blue: 23/255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)]
    }

}

