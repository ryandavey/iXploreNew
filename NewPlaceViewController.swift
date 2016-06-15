//
//  NewPlaceViewController.swift
//  iXploreNew
//
//  Created by Ryan Davey on 6/14/16.
//  Copyright © 2016 Ryan Davey. All rights reserved.
//

import UIKit
import MapKit

class NewPlaceViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    
    
    @IBAction func backButtonTapped(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func saveButtonTapped(sender: UIButton) {
        let latitude: CLLocationDegrees = Double(latitudeField.text!)!
        let longitude: CLLocationDegrees = Double(longitudeField.text!)!
        PlacesController.sharedInstance.addPlace(latitude, longitude: longitude, title: titleField.text, description: descriptionField.text)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
