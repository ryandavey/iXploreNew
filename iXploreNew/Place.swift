//
//  Place.swift
//  MapView
//
//  Created by Julian Hulme on 2016/06/07.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation
import MapKit

class Place:NSObject, MKAnnotation  {
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var title: String? = ""
    var logoURL:String?
    var favorite:Bool?
    
    class func placeList() -> [Place] {
        
        let place = Place ()
        place.title = "Workshop 17"
        place.logoURL = "https://avatars1.githubusercontent.com/u/7220596?v=3&s=200"
        place.coordinate = CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983)
        place.favorite = true
        
        let place2 = Place ()
        place2.title = "Truth Coffee"
        place2.logoURL = "https://robohash.org/123.png"
        place2.coordinate = CLLocationCoordinate2D(latitude: -33.9281976,longitude: 18.4227045)
        
        let place3 = Place ()
        place3.title = "Chop Chop Coffee"
        place3.logoURL = "http://cdn3.ixperience.co.za/assets/icons/interview-step-2-801f63110f89e85e38f27d39f5864a1399f256fe0684844caea2a18c4b6fbd33.svg"
        place3.coordinate = CLLocationCoordinate2D(latitude: -33.9271879,longitude: 18.4327055)
        
        let place4 = Place ()
        place4.title = "Lion's Head"
        place4.logoURL = "https://upload.wikimedia.org/wikipedia/commons/8/84/Lion's_Head,_Signal_Hill_from_the_Summit_of_Table_Mountain.jpg"
        place4.coordinate = CLLocationCoordinate2D(latitude: -33.935642,longitude: 18.388713)
        
        let place5 = Place ()
        place5.title = "Cape Town Stadium"
        place5.logoURL = "https://upload.wikimedia.org/wikipedia/commons/d/dc/The_Cape_Town_Stadium_from_Table_Mountain_Cape_Town_066.jpg"
        place5.coordinate = CLLocationCoordinate2D(latitude: 33.904620,longitude: 18.410101)
        
//        let place6 = Place ()
//        place6.title = "Workshop 17"
//        place6.logoURL = "https://avatars1.githubusercontent.com/u/7220596?v=3&s=200"
//        place6.coordinate = CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983)
//        
//        let place7 = Place ()
//        place7.title = "Workshop 17"
//        place7.logoURL = "https://avatars1.githubusercontent.com/u/7220596?v=3&s=200"
//        place7.coordinate = CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983)
//        
//        let place8 = Place ()
//        place8.title = "Workshop 17"
//        place8.logoURL = "https://avatars1.githubusercontent.com/u/7220596?v=3&s=200"
//        place8.coordinate = CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983)
//        
//        let place9 = Place ()
//        place9.title = "Workshop 17"
//        place9.logoURL = "https://avatars1.githubusercontent.com/u/7220596?v=3&s=200"
//        place9.coordinate = CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983)
//        
//        let place10 = Place ()
//        place10.title = "Workshop 17"
//        place10.logoURL = "https://avatars1.githubusercontent.com/u/7220596?v=3&s=200"
//        place10.coordinate = CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983)
        
        return [place, place2, place3, place4, place5] //, place6, place7, place8, place9, place10]
    }
    
    class func aPlace () -> Place {
        
        let place = Place()
        place.title = "Workshop 17"
        place.coordinate = CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983)
        return place
    }
    
}

extension UIImageView   {
    
    
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
    
}