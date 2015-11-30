//
//  ProfileImageCollectionViewController.swift
//  Apkalu
//
//  Created by Robert Passemar on 11/2/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

//let reuseIdentifier = "Cell"

class ProfileImageCollectionViewController: UICollectionViewController {
    
    var profileImages = [String]()
    
//    var selectedImage:String? {
//        didSet {
//            if let image = selectedImage {
//                selectedImageIndex = profileImages
//            }
//        }
//    }
//    var selectedImageIndex:Int?
//    
//    var selectedImage:String?
    
    @IBAction func backButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
  

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        profileImages = ["Alien.png",
            "Batman.png",
            "Furby.png",
            "Magician.png",
            "Man-1.png",
            "Man-6.png"]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        if (segue.identifier == "SaveImageDetail") {
        // Pass the selected object to the new view controller.
            let cell = sender as! ProfileImageCell
            let image = cell.imageView
            var destination = segue.destinationViewController as! SettingsViewController
            destination.profileImage = image.image
//            if let profileImageCollectionViewController = segue.destinationViewController as? ProfileImageCollectionViewController {
//                profileImageCollectionViewController.selectedImage = UIImage(named: profileImages[image])
//            }
//        } else if (segue.identifier == "SaveProfileImage") {
//            
//            if let cell = sender as? ProfileImageCell {
//                let indexPath = collectionView!.indexPathForCell(cell)
//                if let index = indexPath?.row {
//                    selectedImage = profileImages[index]
//                }
//            }
//            
//        } 
        } else {
            println("the segue id is")
            println(segue.identifier)
        }
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return profileImages.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ProfileImageCell
    
        // Configure the cell
        
        let image = UIImage(named: profileImages[indexPath.row])
        cell.imageView.image = image
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }


    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
