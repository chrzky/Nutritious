//
//  MeView.swift
//  Nutritious
//
//  Created by Christian Frühauf on 11/03/16.
//  Copyright © 2016 ChristianFruhauf. All rights reserved.
//

import UIKit
import SwiftyJSON

class MeView: UITableViewController {

    
    var NumberOfRows = 0
    
    var PhotosOfMyLastMealsArray = [UIImage]()
    var MealsByNameArray = [String]()
    var MealRatingsArray = [Float]()
    var DatesArray = [NSDate]()
    var MealDescriptionArray = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        parseJSON()
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    
    func parseJSON() {
        
        let path : String = NSBundle.mainBundle().pathForResource("jsonFile.json", ofType: "") as String!
        let jsonData = NSData(contentsOfFile: path) as NSData!
        let readableJSON = JSON(data: jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        
        NumberOfRows = readableJSON["MyMeals"].count
        
        for i in 0...NumberOfRows {
            var Meal = "Meal"
            Meal += "\(i)"
            
                if let Photos = readableJSON["Meals"]["MyMeals"][Meal]["Photo"].string as String!,
                    let NamesOfMeals = readableJSON["Meals"]["MyMeals"][Meal]["Name"].string as String!,
                    let Ratings = readableJSON["Meals"]["MyMeals"][Meal]["Rating"].float as Float!,
                    let Descriptions = readableJSON["Meals"]["MyMeals"][Meal]["Description"].string as String! {
            
                        let cacheImage = UIImage(contentsOfFile: Photos)
            
                        PhotosOfMyLastMealsArray.append(cacheImage!)
                        MealsByNameArray.append(NamesOfMeals)
                        MealRatingsArray.append(Ratings)
                        MealDescriptionArray.append(Descriptions)
            
            
                }
        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NumberOfRows
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as? MeCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "myCell") as? MeCell
        }
        
        if MealsByNameArray.count != 0 {
            
            cell!.myLastPostedMeal.image = PhotosOfMyLastMealsArray[indexPath.row]
            cell!.nameOfMeal.text = MealsByNameArray[indexPath.row]
            cell!.ratingSlider.value = MealRatingsArray[indexPath.row]

            
        }
        
        
        return cell!
        
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
