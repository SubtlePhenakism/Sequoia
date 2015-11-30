//
//  SettingsViewController.swift
//  Apkalu
//
//  Created by Robert Passemar on 10/16/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class SettingsViewController: UIViewController {
    
    var profileImage : UIImage?
    
    var profileFile : PFFile? {
        didSet {
            profileImageView.file = profileFile
        }
    }
    
    //@IBOutlet weak var parseProfileImage: PFImageView!
    
    
//    var imageString:String = "Alien.png" {
//        didSet {
//            detailLabel.text? = imageString
//        }
//    }
//
//    @IBOutlet weak var detailLabel: UILabel!
    
    @IBAction func logOutAction(sender: AnyObject){
        
        // Send a request to log out a user
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") as! UIViewController
            self.presentViewController(viewController, animated: true, completion: nil)
        })
        
    }
    
    
    @IBOutlet weak var landlordCode: UITextField!
    
    var code : String?
    
    var propertyAddress : String?
    
    @IBOutlet weak var verifyLandlordCode: DesignableButton!
    
    @IBAction func verifyLandlordAction(sender: AnyObject) {
        if let code = landlordCode.text {
            let propQuery = PFQuery(className: "Property")
            propQuery.whereKey("tenantCode", equalTo: code)
            propQuery.getFirstObjectInBackgroundWithBlock({ (result:PFObject?, error:NSError?) -> Void in
                if error != nil || result == nil {
                    print("The getFirstObject request failed.")
                } else {
                    // The find succeeded.
                    print("Successfully retrieved the object.")
                    if let property = result as PFObject? {
                        self.propertyAddress = property["address"] as? String
                        println(self.propertyAddress)
                        if let user = PFUser.currentUser() as PFUser? {
                            println(user)
                            user["residence"] = property
                            user.saveInBackground()
                            property["currentTenant"] = user
                            property.saveInBackground()
                        }
                    }
                }
            })
            println(code)
        }
    }
    
    @IBAction func cancelToSettingsViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveProfileImageDetail(segue:UIStoryboardSegue) {
        
//        if let profileImageCollectionViewController = segue.sourceViewController as? ProfileImageCollectionViewController,
//            selectedImage = profileImageCollectionViewController.selectedImage {
//                imageString = selectedImage
//                let image = UIImage(named: imageString)
//                profileImage = image
//                self.profileImageView.image = image
//                
//        }
        if let profileImageCollectionViewController = segue.sourceViewController as? ProfileImageCollectionViewController {
            self.profileImageView.image = profileImage
            var userInfo : PFUser
            if let userInfo = PFUser.currentUser(){
                let profileImageData = UIImagePNGRepresentation(profileImage)
                let profileImageFile : PFFile = PFFile(data: profileImageData)
                self.profileFile = profileImageFile
                userInfo["image"] = profileImageFile
                userInfo.saveInBackground()
            }
        }
    }
    
    //var profileImage : UIImage?
    
    @IBOutlet weak var profileImageView: PFImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let user = PFUser.currentUser(){
            var initialThumbnail = UIImage(named: "question")
            self.profileImageView.image = initialThumbnail
            if let userImage = user["image"] as? PFFile {
                self.profileImageView?.file = userImage
                self.profileImageView?.loadInBackground()
            }
        }
//        var initialThumbnail = UIImage(named: "question")
//        self.profileImageView.image = initialThumbnail
//        if let thumbnail = profileFile as PFFile! {
//            self.profileImageView.file = thumbnail
//            self.profileImageView.loadInBackground()
//        }
        
//        if (profileImage == nil){
//            println("test1")
//            var initialThumbnail = UIImage(named: "question")
//            self.profileImageView.image = initialThumbnail
//        } else {
//            println("Smurf")
//            self.profileImageView.image = profileImage
//        }
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
