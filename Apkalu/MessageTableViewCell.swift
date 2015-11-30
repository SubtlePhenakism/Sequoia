//
//  MessageTableViewCell.swift
//  Apkalu
//
//  Created by Robert Passemar on 11/18/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var senderImage: PFImageView!

}
