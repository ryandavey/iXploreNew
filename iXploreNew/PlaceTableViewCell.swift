//
//  PlaceTableViewCell.swift
//  iXploreNew
//
//  Created by Ryan Davey on 6/8/16.
//  Copyright © 2016 Ryan Davey. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    let currentDate = NSDate()
    let dateFormatter = NSDateFormatter()
    
    var placeView: UIImageView?
    var placeLabel: UILabel?
    var dateLabel: UILabel?
    var descriptionField: UITextField?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // frames for placeView, placeLable, datelabel, and the descritptionField
        let viewFrame1 = CGRectMake(8,3,60,60)
        let viewFrame2 = CGRectMake(84,3,157,30)
        let viewFrame3 = CGRectMake(260,3,122,30)
        let viewFrame4 = CGRectMake(84,35,242,30)
        
        placeView = UIImageView(frame: viewFrame1)
        placeLabel = UILabel(frame: viewFrame2)
        placeLabel!.font = placeLabel!.font.fontWithSize(18)
        dateLabel = UILabel(frame: viewFrame3)
        dateLabel!.font = dateLabel!.font.fontWithSize(12)
        descriptionField = UITextField(frame: viewFrame4)
        descriptionField!.font = descriptionField!.font!.fontWithSize(14)
        
        self.addSubview(placeView!)
        self.addSubview(placeLabel!)
        self.addSubview(dateLabel!)
        self.addSubview(descriptionField!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
