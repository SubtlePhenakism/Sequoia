//
//  MessageDetailViewController.swift
//  Apkalu
//
//  Created by Robert Passemar on 12/5/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class MessageDetailViewController: UIViewController {
    
    var currentObject : PFObject?
    
    var messageAuthor : PFUser?
    
    @IBOutlet weak var contactImage: PFImageView!
    @IBOutlet weak var contactUsername: UILabel!
    @IBOutlet weak var contactRole: UILabel!
    
    @IBOutlet weak var messageText: UITextView!
    @IBOutlet weak var sentOnDate: UILabel!
    @IBOutlet weak var replyMessageTextField: UITextField!
    
    @IBAction func sendMessageButton(sender: AnyObject) {
        var message = self.replyMessageTextField.text
        if count(message) < 1 {
            var alert = UIAlertView(title: "Invalid", message: "Please enter a message before sending", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else {
            // Run a spinner to show a task in progress
            var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            var newMessage = PFObject(className: "Message")
            
            newMessage["message"] = message
            newMessage["sender"] = PFUser.currentUser()
            newMessage["receiver"] = self.messageAuthor
            
            newMessage.saveInBackgroundWithBlock({ (succeed, error) -> Void in
                // Stop the spinner
                spinner.stopAnimating()
                if ((error) != nil) {
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Nav") as! UIViewController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })

                }
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let message = currentObject as PFObject? {
            self.messageText.text = message["message"] as? String
            if message.createdAt != nil {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "MM'-'dd'-'yyyy"
                self.sentOnDate.text = dateFormatter.stringFromDate(message.createdAt as NSDate!)
            }
            if let messageSender = message["sender"] as? PFUser {
                self.messageAuthor = messageSender
                self.contactUsername.text = messageSender.username
                self.contactRole.text = messageSender["userRole"] as? String
                if let senderImageFile = messageSender["image"] as? PFFile {
                    self.contactImage.file = senderImageFile
                    self.contactImage.loadInBackground()
                }
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
