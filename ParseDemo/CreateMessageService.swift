//
//  CreateMessageService.swift
//  ParseDemo
//
//  Created by Boris on 28.02.15.
//  Copyright (c) 2015 Boris Musatov. All rights reserved.
//

import Parse

class CreateMessageService {
    
    func saveMessage(content: String) {
        let message: PFObject = PFObject(className: "Message")
        message["content"] = content
        message["user"] = PFUser.currentUser()
        
        message.saveInBackgroundWithBlock(nil)
    }
    
}
