//
//  TimelinePresenter.swift
//  ParseDemo
//
//  Created by Boris on 05.03.15.
//  Copyright (c) 2015 Boris Musatov. All rights reserved.
//

import UIKit
import Parse

class TimelinePresenter {
    
    var userService: UserService?
    
    init() {
        userService = UserService()
    }
    
    func loginDialog() -> UIAlertController {
       return constructLoginDialog()
    }
    
    func showUser(message: PFObject, complete:(user: PFUser) -> ()) {
        self.userService?.findUser(message, { user in
            complete(user: user)
        })
    }
    
    func showMessages(sortOrder: String, complete:(messages: [PFObject]) -> ()) {
        var findAll: PFQuery = PFQuery(className: "Message")
        findAll.findObjectsInBackgroundWithBlock { [unowned self](result: [AnyObject]!, error: NSError!) in
            if error == nil {
                if let data = result as? [PFObject] {
                    complete(messages: sortOrder == "desc" ? data.reverse() : data)
                }
            }
        }
    }
    
    func formatTimeStamp(date: NSDate) -> String {
        let timestamp = date
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        return formatter.stringFromDate(timestamp)
    }
    
    private func constructLoginDialog() -> UIAlertController {
        let loginAlert: UIAlertController = UIAlertController(title: "Login / Sign Up", message: "Please sign up or login", preferredStyle: .Alert)
        loginAlert.addTextFieldWithConfigurationHandler({ (textField: UITextField!) in
            textField.placeholder = "Your username"
        })
        loginAlert.addTextFieldWithConfigurationHandler({ (textField: UITextField!) in
            textField.placeholder = "Your password"
            textField.secureTextEntry = true
        })
        
        // Login
        loginAlert.addAction(UIAlertAction(title: "Login", style: .Default, handler: { [unowned self] (action: UIAlertAction!) in
            let textFields: [UITextField] = loginAlert.textFields as [UITextField]
            let usernameTextField: UITextField = textFields[0]
            let passwordTextField: UITextField = textFields[1]
            
            if !usernameTextField.text.isEmpty && !passwordTextField.text.isEmpty {
                self.userService?.loginUser(usernameTextField.text, passwordTextField.text)
            }
        }))
        
        //  Sign Up
        loginAlert.addAction(UIAlertAction(title: "Sign Up", style: .Default, handler: { (action: UIAlertAction!) in
            let textFields: [UITextField] = loginAlert.textFields as [UITextField]
            let usernameTextField: UITextField = textFields[0]
            let passwordTextField: UITextField = textFields[1]
            
            self.userService?.signupUser(usernameTextField.text, passwordTextField.text)
        }))
        
        return loginAlert
    }
    
}
