//
//  HomeInfo.swift
//  Apkalu
//
//  Created by Robert Passemar on 10/18/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class HomeInfo: PFObject, PFSubclassing {
    
    @NSManaged var image: PFFile
    @NSManaged var user: PFUser
    @NSManaged var title: String?
    
    //1
    class func parseClassName() -> String {
        return "Property"
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
        let query = PFQuery(className: HomeInfo.parseClassName())
        //2
        query.includeKey("user")
        
        query.whereKey("currentTenant", equalTo: PFUser.currentUser()!)
        //3
        println(PFUser.currentUser())
        //query.whereKey("tenant", equalTo: PFUser.currentUser()!)
        //query.orderByDescending("createdAt")
        
        return query
    }
    
    init(image: PFFile, user: PFUser, title:String) {
        super.init()
        
        self.image = image
        self.user = user
        self.title = title as String
    }
    
    override init() {
        super.init()
    }
   
}
