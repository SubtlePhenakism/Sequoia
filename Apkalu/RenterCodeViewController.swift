//
//  RenterCodeViewController.swift
//  Apkalu
//
//  Created by Robert Passemar on 11/16/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit

class RenterCodeViewController: UIViewController {
    
    @IBOutlet weak var renterCodeField: UITextField!
    
    @IBAction func verifyRenterCode(sender: AnyObject) {
        if let code = renterCodeField.text {
            if count(self.renterCodeField.text) < 1 {
                var alert = UIAlertView(title: "Invalid", message: "Please enter your code", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            } else {
                // Run a spinner to show a task in progress
                var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
                spinner.startAnimating()
                
            let propQuery = PFQuery(className: "Property")
            propQuery.whereKey("tenantCode", equalTo: code)
            propQuery.getFirstObjectInBackgroundWithBlock({ (result:PFObject?, error:NSError?) -> Void in
                if error != nil || result == nil {
                    print("The getFirstObject request failed.")
                    var alert = UIAlertView(title: "Invalid", message: "Could not find a matching landlord in your area.", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                } else {
                    // The find succeeded.
                    print("Successfully retrieved the object.")
                    if let property = result as PFObject? {
                        if let user = PFUser.currentUser() as PFUser? {
                            user["residence"] = property
                            user.saveInBackground()
                            property["currentTenant"] = user
                            property.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                                spinner.stopAnimating()
                                
                                if ((error)) != nil {
                                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                                    alert.show()
                                } else {
                                    var alert = UIAlertView(title: "Success", message: "You have verified your landlord", delegate: self, cancelButtonTitle: "OK")
                                    alert.show()
                                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Nav") as! UIViewController
                                        self.presentViewController(viewController, animated: true, completion: nil)
                                    })
                                }
                            })
                        }
                    }
                }
            })
            
            
        }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
