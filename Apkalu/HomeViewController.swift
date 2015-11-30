//
//  ViewController.swift
//  Apkalu
//
//  Created by Robert Passemar on 9/22/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //var homedata = [String]()
    //var messages = []
    //var notes = [AnyObject?]()
    //var leMessages : NSArray = []
    var noteObjects: NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var propertyTitle: UILabel!
    @IBOutlet weak var propertyAddress: UILabel!
    @IBOutlet weak var propertyCity: UILabel!
    @IBOutlet weak var propertyState: UILabel!
    @IBOutlet weak var propertyZip: UILabel!
    @IBOutlet weak var propertyImage: PFImageView!
    @IBOutlet weak var userProfileImage: PFImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageCount: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        if let pUserImage = PFUser.currentUser()?["image"] as? PFFile {
            self.userProfileImage.file = pUserImage
            self.userProfileImage.loadInBackground()
        }
        
        self.fetchAllMessagesFromLocalDatastore()
        
        self.fetchAllMessages()
        
        
        
        
        
        //self.tableView.reloadData()
    }
    
    func fetchAllMessagesFromLocalDatastore() {
        
        var messageQuery = MessageInfo.query()
        
        messageQuery?.fromLocalDatastore()
        
        messageQuery?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            
            if (error == nil) {
                
                var temp: NSArray = objects as NSArray!
                self.noteObjects = temp.mutableCopy() as! NSMutableArray
                self.tableView.reloadData()
                
            } else {
                
                println(error)
            }
        })
    }
    
    func fetchAllMessages() {
        
        PFObject.unpinAllInBackground(nil)
        
        let messageInfo = MessageInfo.query()
        messageInfo?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            
            if (error == nil) {
                
                PFObject.pinAllInBackground(objects, block: nil)
                
                self.fetchAllMessagesFromLocalDatastore()
                
                let numOfMessages : Int = self.noteObjects.count
                
                self.messageCount.text = String(numOfMessages)
                
            } else {
                println(error)
            }
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show the current visitor's username
        if let pUserName = PFUser.currentUser()?["username"] as? String {
            self.userNameLabel?.text = pUserName
        }
        
//        let messageData = MessageInfo.query()
//        messageData?.findObjectsInBackgroundWithBlock({ (object: [PFObject]?, error:NSError?) -> Void in
//            code
//        })
//        notes = messageData
        
        
//        let messageInfo = MessageInfo.query()
//        messageInfo?.findObjectsInBackgroundWithBlock({ (leMessages: [AnyObject]?, error: NSError?) -> Void in
//            for leMessage in leMessages! {
//                let leMessageText = leMessage.message
//                println(leMessageText)
//                if let sender = leMessage["sender"] as? PFUser {
//                    let leSenderName = sender.username
//                    if let senderImage = sender["image"] as? PFFile {
//                        let leSenderImage = senderImage
//                        //let leSenderImage.loadInBackground()
//                    }
//                }
//
//            }
//            })
        
        //self.tableView.reloadData()
        
//        if let pUserImage = PFUser.currentUser()?["image"] as? PFFile {
//            self.userProfileImage.file = pUserImage
//            self.userProfileImage.loadInBackground()
//        }
        
//        if let defaultImage = UIImage(named: "home60") as UIImage? {
//            self.propertyImage.image = defaultImage
//        }
        
        
//        if let initialThumbnail = UIImage(named: "home60") as UIImage? {
//            self.propertyImage.image = initialThumbnail
//        }
        
//        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MessageCell")
//        
//        //self.addGroup.delegate = self
//        tableView.delegate = self
//        tableView.dataSource = self
        
        
        
        //homedata = ["Info", "Messages", "Utilities"]
//        if let messages = [] as? NSArray {
//            
//        }
//        var info = "" as String
//        var utilities = "" as String
       
        
        let homeInfo = HomeInfo.query()
        homeInfo?.findObjectsInBackgroundWithBlock({ (results: [AnyObject]?, error: NSError?) -> Void in
            for result in results! {
                println(result["title"])
                self.propertyTitle.text = result["title"] as? String
                self.propertyAddress.text = result["address"] as? String
                self.propertyCity.text = result["city"] as? String
                self.propertyState.text = result["state"] as? String
                self.propertyZip.text = result["zip"] as? String
                
                var initialPropertyThumbnail = UIImage(named: "home60")
                self.propertyImage.image = initialPropertyThumbnail
                if let propertyThumbnail = result["image"] as? PFFile {
                    self.propertyImage.file = propertyThumbnail
                    self.propertyImage.loadInBackground()
                }
                
                
                
                //self.homedata = (result["messages"] as? [String])!
                
//                if let image = result["image"] as? PFFile {
//                    self.propertyImage?.file = image
//                    self.propertyImage?.loadInBackground()
//                }
//                if (self.propertyImage != nil) {
//                    
//                    self.propertyImage.file = result["image"] as? PFFile
//                    self.propertyImage.loadInBackground()
//                } else {
//                    var initialImage = UIImage(named: "home60")
//                    self.propertyImage.image = initialImage
//                }
                
                
            }
        })
        
        //var CurrentUserId = PFUser.currentUser()
        
        //let predicate = NSPredicate(format: "tenant = PFUser.currentUser(objectId)")
        //var getHomeInfo = PFQuery(className: "Home", predicate: predicate)
        //getHomeInfo.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error: NSError?) -> Void in
        //    if objects!.count > 0 {
        //        for object in objects! {
        //            println(object.title)
        //        }
        //    }
        //}
        //println(getHomeInfo)
        
        //let homeQuery = PFQuery(className: "Home")
        //homeQuery.whereKey(key: "tenant", equalTo:PFUser.currentUser()!)
        
        //let homeQueryInfo = PFQuery
        
        //let query = PFQuery.orQueryWithSubqueries(<#queries: [AnyObject]#>)
        
        
        
        
        
        
        //let predicate = NSPredicate(format: "tenant == userId")
        //var getHomeInfo = PFQuery(className: "Home", predicate: predicate)
        
        //var homeInfo = PFObject(className: "Home")
        
        //self.propertyTitle.text = getHomeInfo["title"]?
        //getHomeInfo["title"] = self.propertyTitle.text
        
        
        
        
        //let predicate = NSPredicate(format:"tenant = 'PFUser.currentUser'"'
        
        //let getHomeInfo = PFQuery(className:"Home")
          //  getHomeInfo.whereKey("tenant", equalTo: PFUser.currentUser()!)
         //   getHomeInfo.findObjectsInBackgroundWithBlock { ([homeInfo]?, error: NSError?) -> Void in
          //  if error == nil {
           //     var homeInfo = getHomeInfo
            //    getHomeInfo.title = self.propertyTitle.text
            //}
       // }
        
    
        
                
        //}
        //}
        
        //getHomeInfo.findObjectsInBackgroundWithTarget(target: Home?, tenant: PFUser.currentUser())
        //if let homeAddress = getHomeInfo.findObjectsInBackgroundWithTarget(self, selector: "title") as? String {
            //self.propertyTitle.text = homeAddress
       // }
        
        
        
        
        //let propertyQuery = PFQuery(className:"Property")
        //if let user = PFUser.currentUser() {
        //    propertyQuery.whereKey("createdBy", equalTo: user)
        //}
        
        //var homeInfo = PFQuery(className: "Home")
        //homeInfo.whereKey("tenant", equalTo: PFUser.currentUser()!)
        //return homeInfo
        
        
        //let homeQuery = PFQuery(className:"Home")
        //if let user = PFUser.currentUser() {
            //let hq = homeQuery.whereKey("tenant", equalTo: user)
        //}
        
        //if let title = hq.self["title"] as? String {
            //propertyTitle?.text = title
        //}
        //if let address = object?["address"] as? String {
            //propertyAddress?.text = address
        //}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//    func queryForTable() -> PFQuery {
//        var query = PFQuery(className: "Message")
//        //query.orderByAscending("title")
//        query.includeKey("sender")
//        query.includeKey("username")
//        query.whereKey("receiver", equalTo: PFUser.currentUser()!)
//        return query
//    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteObjects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MessageTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! MessageTableViewCell
        
        var object : PFObject = self.noteObjects.objectAtIndex(indexPath.row) as! PFObject
        cell.messageText?.text = object["message"] as? String
        
        if let sender = object["sender"] as? PFUser {
            cell.senderName.text = sender.username
            if let senderImage = sender["image"] as? PFFile {
                cell.senderImage.file = senderImage
                cell.senderImage.loadInBackground()
                }
            }

        
        
        
//        let messageInfo = MessageInfo.query()
//        messageInfo?.findObjectsInBackgroundWithBlock({ (items: [AnyObject]?, error: NSError?) -> Void in
//            for item in items! {
//                cell.messageText.text = item.message
//                println(item.message)
//                
//                
//                //println(cell.messageText.text)
////                if let message = item["message"] as? String {
////                    cell.messageText.text = message
////                }
//                if let sender = item["sender"] as? PFUser {
//                    cell.senderName.text = sender.username
//                    if let senderImage = sender["image"] as? PFFile {
//                        cell.senderImage.file = senderImage
//                        cell.senderImage.loadInBackground()
//                    }
//                }
//                //cell.messageText.text = item["message"] as? String
//            }
//        })

        //cell.messageText.text = self.leMessages[indexPath.row] as? String
        
        return cell
    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject) -> PFTableViewCell{
//        
//        var cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! MessageTableViewCell
    
//        if cell == nil {
//            MessageTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MessageCell")
//        }
        
//        let messageQuery = PFQuery(className: "Message")
//        messageQuery.whereKey("receiver", equalTo: PFUser.currentUser()!)
//        messageQuery.findObjectsInBackgroundWithBlock { (messages: [AnyObject]?, error: NSError?) -> Void in
//            for message in messages! {
//                if let messageText = object["message"] as? String {
//                    cell.messageText.text = messageText
//                }
//                if let messageSender = object["sender"] as? PFUser {
//                    cell.senderName.text = messageSender.username
//                }
            //}
        //}
        
        //cell.textLabel!.text = self.homedata[indexPath.row]
        
//        let messageInfo = MessageInfo.query()
//        messageInfo!.findObjectsInBackgroundWithBlock({ (items:[AnyObject]?, error: NSError?) -> Void in
//            for item in items {
//                if message = item["message"] as? String {
//                    println("message")
//                }
//            }
//        })
//        return cell
//    }
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") as! UIViewController
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
    }
}




