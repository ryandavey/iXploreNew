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
    
    
    var placeList: [Place] = Place.placeList()
    
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
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier("PlaceTableViewCell") as? PlaceTableViewCell
        
//        if var placecell = cell {
//            cell!.textLabel?.text = self.placeList[indexPath.row].title
//        } else {
            //cell = PlaceTableViewCell()
        let place = placeList[indexPath.row]
            cell!.placeLabel?.text = self.placeList[indexPath.row].title
            cell!.imageView!.imageFromUrl(place.logoURL!)
        //}
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(88)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupMapView()
        setupTableView()
    }
    
    //func tableView(tableView)
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

