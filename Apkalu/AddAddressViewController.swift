//
//  AddAddressViewController.swift
//  Apkalu
//
//  Created by Robert Passemar on 9/22/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit

class AddAddressViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipField: UITextField!
    
    @IBAction func addUnitAction(sender: AnyObject) {
        
        var property = PFObject(className:"Home")
        property["title"] = self.titleField.text
        property["address"] = self.addressField.text
        //property.setValue(addressField.text, forKey: "address")
        property["city"] = self.cityField.text
        property["state"] = self.stateField.text
        property["zip"] = self.zipField.text
        property["tenant"] = PFUser.currentUser()
        
        if count(self.cityField.text) < 1 {
            var alert = UIAlertView(title: "Invalid", message: "Please enter your city", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if count(stateField.text) < 2 {
            var alert = UIAlertView(title: "Invalid", message: "Please enter your state", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if count(zipField.text) < 5 {
            var alert = UIAlertView(title: "Invalid", message: "Please enter a valid zip code", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
            // Run a spinner to show a task in progress
            var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            //var newProperty = PFObject()
            //newProperty["title"] = title
            
            
            
            property.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                
                spinner.stopAnimating()
                
                if ((error) != nil) {
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                } else {
                    var alert = UIAlertView(title: "Success", message: "New property added!", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Nav") as! UIViewController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                }
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
