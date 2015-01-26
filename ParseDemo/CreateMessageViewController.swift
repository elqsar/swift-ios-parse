//
//  CreateMessageViewController.swift
//  ParseDemo
//
//  Created by Boris on 25.01.15.
//  Copyright (c) 2015 Boris Musatov. All rights reserved.
//

import UIKit
import Parse

class CreateMessageViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var remaining: UILabel!
    
    @IBAction func createMessage() {
        let message: PFObject = PFObject(className: "Message")
        message["content"] = content.text
        message["user"] = PFUser.currentUser()
        
        message.saveInBackgroundWithBlock(nil)
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        content.layer.cornerRadius = 5
        content.becomeFirstResponder()
        content.delegate = self
        content.contentInset = UIEdgeInsetsMake(-content.bounds.height/2 + 10, 0, 0, 0)
        
        remaining.textColor = UIColor(red: 229/255, green: 229/255, blue: 230/255, alpha: 1)
        self.view.backgroundColor = UIColor(red: 43/255, green: 62/255, blue: 80/255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        var newLength: Int = (textView.text as NSString).length + (text as NSString).length - range.length
        var remainingCharactres = 140 - newLength
        
        remaining.text = "\(remainingCharactres)"
        
        return (newLength > 140) ? false : true
    }

}
