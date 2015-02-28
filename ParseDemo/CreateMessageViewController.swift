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
    @IBOutlet weak var done: UIBarButtonItem!
    
    var createMessageService: CreateMessageService?
    
    @IBAction func createMessage() {
        createMessageService?.saveMessage(content.text)
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        content.becomeFirstResponder()
        content.delegate = self
        content.contentInset = UIEdgeInsetsMake(-content.bounds.height/2 + 10, 0, 0, 0)
        done.enabled = false
        
        createMessageService = CreateMessageService()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        var newLength: Int = (textView.text as NSString).length + (text as NSString).length - range.length
        var remainingCharactres = 140 - newLength
        
        remaining.text = "\(remainingCharactres)"
        done.enabled = newLength > 0
        
        return (newLength > 140) ? false : true
    }

}
