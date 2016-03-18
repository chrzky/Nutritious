//
//  UploadSubView.swift
//  Nutritious
//
//  Created by Christian Frühauf on 14/03/16.
//  Copyright © 2016 ChristianFruhauf. All rights reserved.
//

import UIKit
import SwiftyJSON

class UploadSubView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    var pickerDataSource = ["Meat-eaters", "Vegetarians", "Vegans", "Pescetarians"]
    
    var imageToBeUploaded = UIImage!()
    
    var nameOfDishForUpload = String!()
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        /*
        navigationController?.setNavigationBarHidden(false, animated: true)
        let myBackButton: UIButton = UIButton(type: UIButtonType.Custom)
        myBackButton.addTarget(self, action: "popToRoot:", forControlEvents:  UIControlEvents.TouchUpInside)
        myBackButton.setTitle("Back", forState: UIControlState.Normal)
        myBackButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        myBackButton.sizeToFit()
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem = myCustomBackButtonItem
        */
    }
    
    
    @IBAction func backButtonAction(sender: UIButton) {
        
        
        let vc = self.storyboard?.instantiateInitialViewController()
        self.presentViewController(vc! as UIViewController, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    override func viewWillDisappear(animated: Bool) {
        if animated == true {
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    @IBOutlet var notesTextView: UITextView!
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        notesTextView.resignFirstResponder()
    }
    
    
    @IBAction func uploadButtonTapped(sender: AnyObject) {
        
            //let date = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
            //let localDate = dateFormatter.stringFromDate(date)
            //let imageData = UIImagePNGRepresentation(imageToBeUploaded)
            /*
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("CommunityView")
            self.presentViewController(vc! as UIViewController, animated: true, completion: nil)
            */
        
            //let vc = tabBarController?.viewControllers![2]
            //self.showViewController(vc!, sender: nil)
            // tabBarController?.selectedViewController
            
            //self.tabBarController!.selectedIndex = 2
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showTabBarViewController") {
            tabBarController?.selectedIndex = 2
        }
    }
    
}
