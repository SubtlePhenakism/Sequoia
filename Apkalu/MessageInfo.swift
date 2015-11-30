//
//  MessageInfo.swift
//  Apkalu
//
//  Created by Robert Passemar on 11/18/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class MessageInfo: PFObject, PFSubclassing {
    @NSManaged var image: PFFile
    @NSManaged var sender: PFUser
    @NSManaged var message: String?
    
    //1
    class func parseClassName() -> String {
        return "Message"
    }
    
    //2
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    override class func query() -> PFQuery? {
        //1
        let query = PFQuery(className: MessageInfo.parseClassName())
        //2
        query.includeKey("sender")
        
        query.whereKey("receiver", equalTo: PFUser.currentUser()!)
        //3
        
        
        return query
    }
    
    init(image: PFFile, sender: PFUser, message:String) {
        super.init()
        
        self.image = image as PFFile
        self.sender = sender as PFUser
        self.message = message as String
    }
    
    override init() {
        super.init()
    }
}
