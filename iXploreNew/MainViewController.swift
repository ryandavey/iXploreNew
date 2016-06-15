//
//  MainViewController.swift
//  iXplore
//
//  Created by Ryan Davey on 6/8/16.
//  Copyright © 2016 Ryan Davey. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var deletePlaceIndexPath: NSIndexPath? = nil
    var locationManager: CLLocationManager?
    var placeList: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager!.delegate = self
        
        self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager!.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
    
        self.navigationController?.navigationBarHidden = false
        
        let plusButton : UIBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.Plain, target: self, action: "openModal:")
        let logButton : UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("returnHome:"))
        PlacesController.sharedInstance.getPlaces()
        self.navigationItem.leftBarButtonItem = logButton
        self.navigationItem.rightBarButtonItem = plusButton
        // Do any additional setup after loading the view, typically from a nib.
        self.mapView.delegate = self
        setupMapView()
        setupTableView()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapView.setRegion(region, animated: true)
        //self.mapView.showsUserLocation = true

        PlacesController.sharedInstance.addPlace(location.coordinate.latitude, longitude: location.coordinate.longitude, title: "Current Location", description: "")
        
        locationManager!.stopUpdatingLocation()
    }
    
    override func viewWillAppear(animated: Bool) {
        placeList = PlacesController.sharedInstance.getPlaces()
        tableView.reloadData()
        
    }
    
    /*  OpenModal
     *
     *  Opens the NewPlaceViewController as a modal
     *  excecuted when the + button (on navigation bar) is pressed
     */
    func openModal(Sender: UIBarButtonItem!) {
        let secondViewController:NewPlaceViewController = NewPlaceViewController()
        self.presentViewController(secondViewController, animated: true, completion: nil)
        self.navigationController?.navigationBarHidden = false
    }
    
    func setupMapView () {
        self.mapView.mapType = .Hybrid
    }
    
    func setupTableView () {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(PlaceTableViewCell.self, forCellReuseIdentifier: "PlaceTableViewCell")
        let control = PlacesController()
        control.getPlaces()
        //control.
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
        
        //Get date
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        let convertedDate = dateFormatter.stringFromDate(currentDate)
        
        // get cell and setup contents
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceTableViewCell") as? PlaceTableViewCell
       let place = placeList[indexPath.row]
        cell!.dateLabel!.text = convertedDate
        cell!.placeLabel!.text = self.placeList[indexPath.row].title
//        cell!.placeView!.image = UIImage(named: place.logoURL!)
        cell!.descriptionField!.text = self.placeList[indexPath.row].detail
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
            mapView.removeAnnotation(placeList[indexPath.row])
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
    
    func mapView(mapView: MKMapView!,viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            
            let place: Place = annotation as! Place
            if (place.favorite != nil) {
                if place.favorite! == true {
                    pinView!.pinTintColor = UIColor.yellowColor()
                } else {
                    pinView!.pinTintColor = UIColor.redColor()
                }
            } else {
            pinView!.annotation = annotation
            }
    }
        return pinView
}
    func favoritePlace (indexPath: NSIndexPath) {
        mapView.removeAnnotation(placeList[indexPath.row])
        
        
        mapView.addAnnotation(placeList[indexPath.row])
        placeList[indexPath.row].favorite = true
    }
    func deletePlace (indexPath: NSIndexPath) {
        mapView.removeAnnotation(placeList[indexPath.row])
        placeList.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // This is a generic implementation of the table data source method for adding row actions.
    // Adapt it to match your needs.
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let action1 = UITableViewRowAction(style: .Normal, title: "Favorite") { action, index in
            self.favoritePlace(indexPath)
            print("Action 1 tapped")
        }
        action1.backgroundColor = UIColor.orangeColor()
        
        let action2 = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
            self.deletePlace(indexPath)
            print("Action 2 tapped")
        }
        action2.backgroundColor = UIColor.redColor()
        
        return [action1, action2]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

