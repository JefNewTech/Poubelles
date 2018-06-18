//
//  AnnotationVue.swift
//  Poubelles
//
//  Created by Jean-François Coquerelle on 17/06/18.
//  Copyright © 2018 Jean-François Coquerelle. All rights reserved.
//

import UIKit
import MapKit

class AnnotationVue: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard (newValue as? MonAnnotation) != nil else { return }
            image = #imageLiteral(resourceName: "Group")
        }
    }
    
}
