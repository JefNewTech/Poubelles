//
//  CLLocationExtension.swift
//  Poubelles
//
//  Created by Jean-François Coquerelle on 17/06/18.
//  Copyright © 2018 Jean-François Coquerelle. All rights reserved.
//

import UIKit
import MapKit

extension CarteController: CLLocationManagerDelegate {
    
    func miseEnPlace() {
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            locationManager.stopUpdatingLocation()
            let maPosition = locations[0]
            let coordonnees = maPosition.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: coordonnees, span: span)
            carte.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
