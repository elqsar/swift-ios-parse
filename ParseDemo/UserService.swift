//
//  TimelinePresenter.swift
//  ParseDemo
//
//  Created by Boris on 28.02.15.
//  Copyright (c) 2015 Boris Musatov. All rights reserved.
//

import Parse

class UserService {
    
    func loginUser(username:String, _ password:String) {
        PFUser.logInWithUsernameInBackground(username, password: password, { (user: PFUser!, error: NSError!) in
            if error == nil {
                println("Login successful")
            } else {
                println("Login fails")
            }
        })
    }

    func signupUser(username:String, _ password:String) {
        let user:PFUser = PFUser()
        user.username = username
        user.password = password
        
        user.signUpInBackgroundWithBlock { (success: Bool!, error: NSError!) in
            if error == nil {
                println("Sign up successfully")
            } else {
                if let userError: String? = error.userInfo?["error"] as? String {
                    println(userError)
                }
            }
        }
    }
    
    func findUser(message: PFObject, complete:(user: PFUser) -> ()) {
        var findUser: PFQuery = PFUser.query()
        findUser.whereKey("objectId", equalTo: message.objectForKey("user").objectId)
        findUser.findObjectsInBackgroundWithBlock { (result: [AnyObject]!, error: NSError!) in
            if error == nil {
                if result != nil && result.count > 0 {
                    if let user = (result as [PFUser]).last {
                       complete(user: user)
                    }
                }
            }
        }
    }
    
}
