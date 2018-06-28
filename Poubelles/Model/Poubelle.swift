//
//  Poubelle.swift
//  Poubelles
//
//  Created by Jean-François Coquerelle on 17/06/18.
//  Copyright © 2018 Jean-François Coquerelle. All rights reserved.
//

import Foundation

struct Poubelles: Decodable {
    let features: [Features]
}

struct Features: Decodable {
    let properties: properties
    let geometry: geometry
}
struct properties: Decodable {
    let name: String
    let desc: String
}
struct geometry: Decodable {
    let coordinates: [Double]
}
