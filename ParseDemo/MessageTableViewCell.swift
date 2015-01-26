//
//  MessageTableViewCell.swift
//  ParseDemo
//
//  Created by Boris on 25.01.15.
//  Copyright (c) 2015 Boris Musatov. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var message: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        username.textColor = UIColor(red: 229/255, green: 229/255, blue: 230/255, alpha: 1)
        time.textColor = UIColor(red: 229/255, green: 229/255, blue: 230/255, alpha: 1)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
