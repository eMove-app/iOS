//
//  PlaceMarker.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import GoogleMaps

class PlaceMarker: GMSMarker {
    let place: PinPoint
    
    init(place: PinPoint) {
        self.place = place
        super.init()
        
        position = CLLocationCoordinate2D(latitude: place.latitude ?? 0.0, longitude: place.longitude ?? 0.0)
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = .pop
    }
}
