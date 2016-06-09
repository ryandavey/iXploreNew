//
//  PlaceTableViewCell.swift
//  iXploreNew
//
//  Created by Ryan Davey on 6/8/16.
//  Copyright © 2016 Ryan Davey. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    var rate = 0

    @IBOutlet weak var placeView: UIImageView!

    
    @IBOutlet weak var placeLabel: UILabel!
  
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    @IBAction func button1a(sender: UIButton) {
        setRating(1)
    }
    @IBAction func button2a(sender: UIButton) {
        setRating(2)
    }
    @IBAction func button3a(sender: UIButton) {
        setRating(3)
    }
    @IBAction func button4a(sender: UIButton) {
        setRating(4)
    }
    @IBAction func button5a(sender: UIButton){
        setRating(5)
    }
    
    func setRating(rating: Int) {
        let image1 = UIImage(named: "star_pink.png") as UIImage!
        let image2 = UIImage(named: "star_black.png") as UIImage!
        if rating == 1 {
            self.button1.setImage(image1, forState: .Normal)
            self.button2.setImage(image2, forState: .Normal)
            self.button3.setImage(image2, forState: .Normal)
            self.button4.setImage(image2, forState: .Normal)
            self.button5.setImage(image2, forState: .Normal)
        } else if rating == 2 {
            self.button1.setImage(image1, forState: .Normal)
            self.button2.setImage(image1, forState: .Normal)
            self.button3.setImage(image2, forState: .Normal)
            self.button4.setImage(image2, forState: .Normal)
            self.button5.setImage(image2, forState: .Normal)
        } else if rating == 3 {
            self.button1.setImage(image1, forState: .Normal)
            self.button2.setImage(image1, forState: .Normal)
            self.button3.setImage(image1, forState: .Normal)
            self.button4.setImage(image2, forState: .Normal)
            self.button5.setImage(image2, forState: .Normal)
        } else if rating == 4 {
            self.button1.setImage(image1, forState: .Normal)
            self.button2.setImage(image1, forState: .Normal)
            self.button3.setImage(image1, forState: .Normal)
            self.button4.setImage(image1, forState: .Normal)
            self.button5.setImage(image2, forState: .Normal)
        } else {
            self.button1.setImage(image1, forState: .Normal)
            self.button2.setImage(image1, forState: .Normal)
            self.button3.setImage(image1, forState: .Normal)
            self.button4.setImage(image1, forState: .Normal)
            self.button5.setImage(image1, forState: .Normal)
        }
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
