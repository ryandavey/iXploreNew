//
//  PlacesController.swift
//  iXploreNew
//
//  Created by Ryan Davey on 6/14/16.
//  Copyright © 2016 Ryan Davey. All rights reserved.
//

import Foundation
import MapKit

class PlacesController: NSObject {
    
    class var sharedInstance: PlacesController {
        struct Static {
            static var instance:PlacesController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)    {
            Static.instance = PlacesController()
        }
        return Static.instance!
    }

    func addPlace (latitude: Double, longitude: Double, title: String?, description: String?) {
        let newPlace = Place(latitude: latitude, longitude: longitude, title: title!, detail: description!)
        var previous = self.getPlaces()
        previous.append(newPlace)
        PersistenceManager.saveNSArray(previous, fileName: "placesVisited")
        
    }

    
//    private func readPlacesFromMemory () {
//        var result = PersistenceManager.loadNSArray("placesVisited")
//        let places = result as? [Place]
//        if places == nil {
//            result += []
//        } else {
//            result += places!
//        }
//    }

    func getPlaces() -> [Place] {
        
        var previous = PersistenceManager.loadNSArray("placesVisited") as? [Place]
        if previous == nil {
            previous = []
        }
        
        print("There are: " + String(previous!.count))
        
        return previous!
    }
    
}



