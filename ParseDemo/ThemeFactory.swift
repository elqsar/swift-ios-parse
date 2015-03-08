//
//  ThemeFactory.swift
//  ParseDemo
//
//  Created by Boris on 08.03.15.
//  Copyright (c) 2015 Boris Musatov. All rights reserved.
//

import UIKit

final class ThemeFactory {
    
    private init() {}
    
    struct ColorConstants {
        static let BAR_TINT = UIColor(red: 223/255, green: 105/255, blue: 23/255, alpha: 1)
        static let TINT = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        static let TEXT_FOREGROUND = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
    }
    
    class func navigationBarTheme() {
        UINavigationBar.appearance().barTintColor = ColorConstants.BAR_TINT
        UINavigationBar.appearance().tintColor = ColorConstants.TINT
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: ColorConstants.TEXT_FOREGROUND]
    }
}
