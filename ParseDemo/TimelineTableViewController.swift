//
//  TimelineTableViewController.swift
//  ParseDemo
//
//  Created by Boris on 25.01.15.
//  Copyright (c) 2015 Boris Musatov. All rights reserved.
//

import UIKit
import Parse

class TimelineTableViewController: UITableViewController {
    
    var messages: [PFObject] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if PFUser.currentUser() == nil {
            let loginAlert: UIAlertController = UIAlertController(title: "Login / Sign Up", message: "Please sign up or login", preferredStyle: .Alert)
            loginAlert.addTextFieldWithConfigurationHandler({ (textField: UITextField!) in
                textField.placeholder = "Your username"
            })
            loginAlert.addTextFieldWithConfigurationHandler({ (textField: UITextField!) in
                textField.placeholder = "Your password"
                textField.secureTextEntry = true
            })
            
            // Login
            loginAlert.addAction(UIAlertAction(title: "Login", style: .Default, handler: { (action: UIAlertAction!) in
                let textFields: [UITextField] = loginAlert.textFields as [UITextField]
                let usernameTextField: UITextField = textFields[0]
                let passwordTextField: UITextField = textFields[1]
                
                if !usernameTextField.text.isEmpty && !passwordTextField.text.isEmpty {
                    PFUser.logInWithUsernameInBackground(usernameTextField.text, password: passwordTextField.text, { (user: PFUser!, error: NSError!) in
                        if error == nil {
                            println("Login successful")
                        } else {
                            println("Login fails")
                        }
                    })
                }
            }))
            
            //  Sign Up
            loginAlert.addAction(UIAlertAction(title: "Sign Up", style: .Default, handler: { (action: UIAlertAction!) in
                let textFields: [UITextField] = loginAlert.textFields as [UITextField]
                let usernameTextField: UITextField = textFields[0]
                let passwordTextField: UITextField = textFields[1]
                
                let user:PFUser = PFUser()
                user.username = usernameTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackgroundWithBlock { (success: Bool!, error: NSError!) in
                    if error == nil {
                        println("Sign up successfully")
                    } else {
                        if let userError: String? = error.userInfo?["error"] as? String {
                            println(userError)
                        }
                    }
                }
            }))
            
            self.presentViewController(loginAlert, animated: true, completion: nil)
        }
        
        self.loadMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as MessageTableViewCell
        
        let message = messages[indexPath.row]
        
        cell.message.alpha = 0
        cell.time.alpha = 0
        cell.username.alpha = 0
        
        cell.message.text = message.objectForKey("content") as? String
        
        var findUser: PFQuery = PFUser.query()
        findUser.whereKey("objectId", equalTo: message.objectForKey("user").objectId)
        findUser.findObjectsInBackgroundWithBlock { (result: [AnyObject]!, error: NSError!) in
            if error == nil {
                let user = (result as [PFUser]).last
                cell.username.text = user?.username
                
                UIView.animateWithDuration(0.5, animations: {
                    cell.message.alpha = 1
                    cell.time.alpha = 1
                    cell.username.alpha = 1
                })
            }
        }
        
        let timestamp = message.createdAt as NSDate
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        cell.time.text = formatter.stringFromDate(timestamp)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    @IBAction func loadMessages() {
        messages.removeAll(keepCapacity: false)
        
        var findAll: PFQuery = PFQuery(className: "Message")
        findAll.findObjectsInBackgroundWithBlock { [unowned self](result: [AnyObject]!, error: NSError!) in
            if error == nil {
                if let data = result as? [PFObject] {
                    self.messages = data.reverse()
                }
            }
        }
    }
}
