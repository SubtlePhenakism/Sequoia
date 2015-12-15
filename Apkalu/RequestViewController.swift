//
//  RequestViewController.swift
//  Apkalu
//
//  Created by Robert Passemar on 12/9/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePicker : UIImagePickerController!
    
    var requestSubject = "Untitled"
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func photoButton(sender: AnyObject) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera
            
            presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            var alert = UIAlertView(title: "No camera detected", message: "Please try a new device", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        
    }
    @IBAction func choosePhotoButton(sender: AnyObject) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }

    @IBOutlet weak var noteBox: UITextField!
    @IBAction func addNote(sender: AnyObject) {
        self.noteBox.hidden = false
    }
    
    @IBAction func sendRequest(sender: AnyObject) {
        var note = self.noteBox.text
        if imageView == nil {
            var alert = UIAlertView(title: "Invalid", message: "Please include a picture before sending", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else if requestSubject == "Untitled" {
            var alertController = UIAlertController(
                title: "Send Request",
                message: "To send, please enter a subject and press OK",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            var okAction = UIAlertAction(
                title: "OK", style: UIAlertActionStyle.Default) {
                    (action) -> Void in
                    self.requestSubject = (alertController.textFields?.first as! UITextField).text
                    if let user = PFUser.currentUser() {
                        var username = user.username
                        var landlord : PFUser
                        let pictureData = UIImagePNGRepresentation(self.imageView.image)
                        if let location = user["residence"] as? PFObject {
                            landlord = (location["owner"] as? PFUser)!
                            var newRequest = PFObject(className: "Request")
                            newRequest["note"] = note
                            newRequest["location"] = location
                            newRequest["sender"] = user
                            newRequest["receiver"] = landlord
                            newRequest["subject"] = self.requestSubject
                            newRequest["status"] = "pending"
                            newRequest["image"] = PFFile(name: "image", data: pictureData)
                            newRequest.saveInBackgroundWithBlock({ (success, error) -> Void in
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
                            
                            var message = "New Request - \(self.requestSubject)"
                            var newMessage = PFObject(className: "Message")
                            newMessage["message"] = message
                            newMessage["sender"] = user
                            newMessage["receiver"] = landlord
                            newMessage.saveInBackground()
                        }
                    }
            }
            
            alertController.addTextFieldWithConfigurationHandler {
                (txtSubject) -> Void in
                txtSubject.placeholder = "Subject"
            }
            
            alertController.addAction(okAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.noteBox.hidden = true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
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
