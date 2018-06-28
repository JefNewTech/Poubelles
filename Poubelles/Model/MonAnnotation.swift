//
//  MonAnnotation.swift
//  Poubelles
//
//  Created by Jean-François Coquerelle on 17/06/18.
//  Copyright © 2018 Jean-François Coquerelle. All rights reserved.
//

import UIKit
import MapKit
import AddressBook

class MonAnnotation: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var desc: String?
    var coordinate: CLLocationCoordinate2D
    
    init(titre: String, adresse: String, descr: String, coordonnes: CLLocationCoordinate2D) {
        self.title = titre
        self.subtitle = adresse
        self.desc = descr
        self.coordinate = coordonnes
        super.init()
    }
}
