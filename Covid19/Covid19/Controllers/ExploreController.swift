//
//  ExploreController.swift
//  Covid19
//
//  Created by Kate Vu (Quyen) on 29/5/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ExploreViewController : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        setUpSearchBar()
        
        mapView.delegate = self
        mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate, span: span)
            //let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: 800, longitudinalMeters: 800)
            mapView.setRegion(coordinateRegion, animated: true)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func mapView(
        _ mapView: MKMapView,
        annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl
    ) {
        guard let pinAnnotation = view.annotation as? PinAnnotation else {
            return
        }
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        pinAnnotation.mapItem?.openInMaps(launchOptions: launchOptions)
    }
    
    private func setUpSearchBar() {
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.sizeToFit()
        
        self.searchController.searchBar.showsScopeBar = false // you can show/hide this dependant on your layout
        self.searchController.searchBar.placeholder = "Search"
        
        self.navigationItem.titleView = self.searchController.searchBar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchController.searchBar.text {
            self.searchPlaces(searchText)
            self.searchController.isActive = false
        }
    }
    
    func searchPlaces(_ searchBarText: String) {
        mapView.removeAnnotations(mapView.annotations)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            if error != nil {
                print("Error occurred in search:\(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                self.processMapItems(response!.mapItems)
            }
        })
    }
    
    func processMapItems(_ mapItems: [MKMapItem]) {
        for item in mapItems {
            let annotation = PinAnnotation(title: item.name,
                                           locationName: item.placemark.title,
                                           coordinate: item.placemark.coordinate)
            
            self.mapView.addAnnotation(annotation)
        }
    }
}

