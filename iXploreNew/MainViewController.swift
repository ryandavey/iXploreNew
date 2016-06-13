//
//  MainViewController.swift
//  iXplore
//
//  Created by Ryan Davey on 6/8/16.
//  Copyright © 2016 Ryan Davey. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var deletePlaceIndexPath: NSIndexPath? = nil
    
    var placeList: [Place] = Place.placeList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupMapView()
        setupTableView()
    }
    
    func setupMapView () {
        self.mapView.mapType = .Hybrid
    }
    
    func setupTableView () {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let nib: UINib = UINib(nibName: "PlaceTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "PlaceTableViewCell")
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let place = placeList[indexPath.row]
        
        let mapCenterCoordinateAfterMove = CLLocationCoordinate2D(latitude: self.placeList[indexPath.row].coordinate.latitude,longitude: self.placeList[indexPath.row].coordinate.longitude)
        let adjustedRegion = mapView.regionThatFits(MKCoordinateRegionMake(mapCenterCoordinateAfterMove,
            MKCoordinateSpanMake(0.01, 0.01)))
        mapView.setRegion(adjustedRegion, animated: true)
        mapView.addAnnotation(place)
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeList.count 
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        let convertedDate = dateFormatter.stringFromDate(currentDate)
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceTableViewCell") as? PlaceTableViewCell
        let place = placeList[indexPath.row]
        cell!.dateLabel.text = convertedDate
        cell!.placeLabel?.text = self.placeList[indexPath.row].title
        cell!.imageView!.imageFromUrl(place.logoURL!)
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return CGFloat(88)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            deletePlaceIndexPath = indexPath
            let placeToDelete = String(placeList[indexPath.row])
            confirmDelete(placeToDelete)
        }
    }
    func confirmDelete(place: String) {
        let alert = UIAlertController(title: "Delete Planet", message: "Are you sure you want to permanently delete \(place)?", preferredStyle: .ActionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeletePlace)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeletePlace)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func handleDeletePlace(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deletePlaceIndexPath {
            tableView.beginUpdates()
            
            placeList.removeAtIndex(indexPath.row)
            
            // Note that indexPath is wrapped in an array:  [indexPath]
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            deletePlaceIndexPath = nil
            
            tableView.endUpdates()
        }
    }
    
    func cancelDeletePlace(alertAction: UIAlertAction!) {
        deletePlaceIndexPath = nil
    }
    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        let annotationView = MKAnnotationView()
//        let place: Place = annotation as! Place
//        if (place.favorite != nil) {
//            if place.favorite! {
//                annotationView.tintColor = UIColor.yellowColor()
//            } else {
//                annotationView.tintColor = UIColor.redColor()
//            }
//        return annotationView
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

