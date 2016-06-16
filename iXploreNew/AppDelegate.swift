//
//  AppDelegate.swift
//  iXploreNew
//
//  Created by Ryan Davey on 6/8/16.
//  Copyright © 2016 Ryan Davey. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MKMapViewDelegate,CLLocationManagerDelegate {

    var window: UIWindow?
    var location: CLLocation!
    var mainNavigationController: UINavigationController?
    
    var locationManager: CLLocationManager?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager!.delegate = self
        self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let mainViewController = MainViewController(nibName: "MainViewController", bundle:nil)
        mainNavigationController = UINavigationController(rootViewController: mainViewController)
        self.window?.rootViewController = self.mainNavigationController
        
        self.window?.makeKeyAndVisible()
        
        self.mainNavigationController?.navigationBarHidden = true
        return true
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        location = locations.last! as CLLocation
        
        //        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        //
        //        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        //
        //        self.mapView.setRegion(region, animated: true)
        print(location)
        
        PlacesController.sharedInstance.addPlace(location.coordinate.latitude, longitude: location.coordinate.longitude, title: "Current Location", description: "")
        
        locationManager!.stopUpdatingLocation()
    }
    
    func locationManager(manager:CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .NotDetermined:
            locationManager!.requestAlwaysAuthorization()
            break
        case .AuthorizedWhenInUse:
            locationManager!.startUpdatingLocation()
            
            break
        case .AuthorizedAlways:
            locationManager!.startUpdatingLocation()
            break
        case .Restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            break
        case .Denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
        default:
            break
        }
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

