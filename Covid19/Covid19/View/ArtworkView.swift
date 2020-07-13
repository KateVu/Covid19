//
//  ArtworkView.swift
//  Covid19
//
//  Created by Kate Vu (Quyen) on 29/5/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//  Ref: https://www.raywenderlich.com/
//

import Foundation
import MapKit

class ArtworkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
    }
}

class ArtworkView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let pinAnnotation = newValue as? PinAnnotation else {
                return
            }
            
            canShowCallout = true
            calloutOffset = CGPoint(x: 0, y: 0)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
            mapsButton.setBackgroundImage(#imageLiteral(resourceName: "Direction"), for: .normal)
            rightCalloutAccessoryView = mapsButton
            
            image = pinAnnotation.image

            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = pinAnnotation.subtitle
            
            detailCalloutAccessoryView = detailLabel
        }
    }
}
