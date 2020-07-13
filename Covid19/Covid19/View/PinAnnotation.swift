//
//  PinAnnotation.swift
//  Covid19
//
//  Created by Kate Vu (Quyen) on 29/5/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//  Ref: https://www.raywenderlich.com/


import Foundation
import MapKit
import Contacts

class PinAnnotation: NSObject, MKAnnotation {
    let locationTitle: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init (
        title: String?,
        locationName: String?,
        coordinate: CLLocationCoordinate2D
    ) {
        self.locationTitle = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    var title: String? {
        return locationTitle
    }
    
    var mapItem: MKMapItem? {
        guard let location = locationName else {
            return nil
        }
        
        let addressDict = [CNPostalAddressStreetKey: location]
        
        let placemark = MKPlacemark(
            coordinate: coordinate,
            addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = locationTitle
        
        return mapItem
    }
    
    /*
    var markerTintColor: UIColor  {
        return .red
    }
    */

    var image: UIImage {
        return #imageLiteral(resourceName: "Pin")
    }
}
