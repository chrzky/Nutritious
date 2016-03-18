//
//  NutritiousTests.swift
//  NutritiousTests
//
//  Created by Christian Frühauf on 11/03/16.
//  Copyright © 2016 ChristianFruhauf. All rights reserved.
//

import XCTest

@testable import Nutritious

class NutritiousTests: XCTestCase {
    
    var testImage = UIImage()
    var testDate = NSDate()
    
    func testMealInitialization() {
        // Success case
        let potentialItem = Meal(photo: testImage, nameOfMeal: "Schweinsbraten", rating: 5, username: "Sepp", date: testDate)
        
        
    }
    
}
