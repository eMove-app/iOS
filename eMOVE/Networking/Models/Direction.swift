//
//  Directions.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper

public class Direction {
    var rideId: Int?
    var singlePolyline: String?
    var initialPolyline: String?
    var updatedPolyline: String?
    var user: User?
    
    required public init?(map: Map) {}
}

extension Direction: Mappable {
    public func mapping(map: Map) {
        rideId <- map["id"]
        singlePolyline <- map["directions.0.overview_polyline.points"]
        initialPolyline <- map["initial.directions.overview_polyline.points"]
        updatedPolyline <- map["updated.directions.overview_polyline.points"]
        user <- map["user"]
    }
}
