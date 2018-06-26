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
    let image = #imageLiteral(resourceName: "Group")
    var coordinate: CLLocationCoordinate2D
    
    init(titre: String, adresse: String, coordonnes: CLLocationCoordinate2D) {
        self.title = titre
        self.subtitle = adresse
        self.coordinate = coordonnes
        super.init()
    }
}
