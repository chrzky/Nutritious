//
//  MeCell.swift
//  Nutritious
//
//  Created by Christian Frühauf on 17/03/16.
//  Copyright © 2016 ChristianFruhauf. All rights reserved.
//

import UIKit

class MeCell: UITableViewCell {
    
    
    
    @IBOutlet weak var myLastPostedMeal: UIImageView!
    
    @IBOutlet weak var nameOfMeal: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var ratingSlider: UISlider!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
}
