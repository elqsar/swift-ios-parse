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
    
    var timelinePresenter: TimelinePresenter = TimelinePresenter()
    
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
            let loginAlert = timelinePresenter.loginDialog()
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MessageTableViewCell
        
        let message = messages[indexPath.row]
        cell.message.text = message.objectForKey("content") as? String
        
        timelinePresenter.showUser(message) { user in
            cell.username.text = user.username
        }
        
        if let timestamp = message.createdAt {
            cell.time.text = timelinePresenter.formatTimeStamp(timestamp)
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    @IBAction func loadMessages() {
        messages.removeAll(keepCapacity: false)
        
        timelinePresenter.showMessages("desc") { [unowned self] messages in
            self.messages = messages
        }
    }
}
