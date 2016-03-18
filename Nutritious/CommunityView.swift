//
//  CommunityView.swift
//  Nutritious
//
//  Created by Christian Frühauf on 11/03/16.
//  Copyright © 2016 ChristianFruhauf. All rights reserved.
//

import UIKit
import SwiftyJSON

class CommunityView: UITableViewController {
    
    var NumberOfRows = 0
    
    var PhotosOfMealsArray = [UIImage]()
    var MealsByNameArray = [String]()
    var MealRatingsArray = [Float]()
    var UsernamesArray = [String]()
    var MealDescriptionArray = [String]()
    
    var communityCell = CommunityCell()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        parseJSON()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    func parseJSON()    {
        
        let path : String = NSBundle.mainBundle().pathForResource("jsonFile.json", ofType: "") as String!
        let jsonData = NSData(contentsOfFile: path) as NSData!
        let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        
        // only handling meat-eaters community right now
        NumberOfRows = readableJSON["Meat-eaters"].count
        
        for i in 0...NumberOfRows {
            var Meal = "Meal"
            Meal += "\(i)"
            
            if let Photos = readableJSON["Meals"]["Meat-eaters"][Meal]["Photo"].string as String!,
                let NamesOfMeals = readableJSON["Meals"]["Meat-eaters"][Meal]["Name"].string as String!,
                let Ratings = readableJSON["Meals"]["Meat-eaters"][Meal]["Rating"].float as Float!,
                let Usernames = readableJSON["Meals"]["Meat-eaters"][Meal]["Username"].string as String! {
            
                    let imageCache = UIImage(contentsOfFile: Photos)
            
                    PhotosOfMealsArray.append(imageCache!)
                    MealsByNameArray.append(NamesOfMeals)
                    MealRatingsArray.append(Ratings)
                    UsernamesArray.append(Usernames)
                    
            }
        }
        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NumberOfRows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommunityCell", forIndexPath: indexPath)
        
        if MealsByNameArray.count != 0 {
            
            communityCell.postedImage.image = PhotosOfMealsArray[indexPath.row]
            communityCell.nameOfMeal.text = MealsByNameArray[indexPath.row]
            communityCell.ratingSlider.value = MealRatingsArray[indexPath.row]
            communityCell.addedBy.text = UsernamesArray[indexPath.row]
           
    
            
        }
        
        
        return cell
        
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
