//
//  SecondViewController.swift
//  Nutritious
//
//  Created by Christian Frühauf on 11/03/16.
//  Copyright © 2016 ChristianFruhauf. All rights reserved.
//

import UIKit
import SwiftyJSON

class UploadView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    
    
    @IBOutlet weak var previewImage: UIImageView!
    
    var fromCameraToUploadView = UIImage!()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "sendImageSegue") {
            if let destination = segue.destinationViewController as? UploadSubView {
                destination.imageToBeUploaded = previewImage.image
                destination.nameOfDishForUpload = nameOfDishTextView.text
            }
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewImage.image = fromCameraToUploadView
        nameOfDishTextView.text = "(enter the name of this dish)"
        nameOfDishTextView.layer.cornerRadius = 10
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardNotification:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        if nameOfDishTextView == "" {
            let alert = UIAlertController()
            alert.message = "Enter name of the meal to continue"
        }
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        previewImage.hidden = false
    }
    
    // This function moves the nameOfDishTextView up a notch so that you can see it while typing
    
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            let duration:NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.unsignedLongValue ?? UIViewAnimationOptions.CurveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
            previewImage.hidden = true
            
            if endFrame?.origin.y >= UIScreen.mainScreen().bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 20.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animateWithDuration(duration,
                delay: NSTimeInterval(0),
                options: animationCurve,
                animations: { self.view.layoutIfNeeded() },
                completion: nil)
        }
    }
    
    
    
    
    @IBAction func chooseImageTapped(sender: AnyObject) {
        
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary)!
        imagePicker.allowsEditing = false
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [NSObject : AnyObject]!) {
        
        self.previewImage.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet var nameOfDishTextView: UITextView!
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        nameOfDishTextView.resignFirstResponder()
        previewImage.hidden = false
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
