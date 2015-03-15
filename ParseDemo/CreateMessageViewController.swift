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
        
        self.automaticallyAdjustsScrollViewInsets = false

        done.enabled = false
        
        createMessageService = CreateMessageService.sharedInstance
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        var newLength: Int = (textView.text as NSString).length + (text as NSString).length - range.length
        var remainingCharactres = 140 - newLength
        
        remaining.text = remainingCharactres > 0 ? "\(remainingCharactres)" : "\(0)"
        done.enabled = newLength > 0
        
        return (newLength > 140) ? false : true
    }
}
