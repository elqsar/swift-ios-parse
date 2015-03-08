//
//  ParseUtils.swift
//  ParseDemo
//
//  Created by Boris on 08.03.15.
//  Copyright (c) 2015 Boris Musatov. All rights reserved.
//
import Foundation
import Parse

final class ParseUtils {
    
    private init() {}
    
    struct Config {
        static let APP_ID = "application_id"
        static let CLIENT_ID = "client_id"
    }
    
    class func initParse() {
        if let path = NSBundle.mainBundle().pathForResource("AppConfig", ofType: "plist") {
            if let config = NSDictionary(contentsOfFile: path) as? Dictionary<String, String> {
                Parse.enableLocalDatastore()
                Parse.setApplicationId(config[Config.APP_ID], clientKey: config[Config.CLIENT_ID])
            }
        }
    }
}
