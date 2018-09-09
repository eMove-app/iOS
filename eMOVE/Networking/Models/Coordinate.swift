//
//  Coordinate.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper

public class Coordinate {
    var latitude: Double?
    var longitude: Double?
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    required public init?(map: Map) {}
}

extension Coordinate: Mappable {
    public func mapping(map: Map) {
        latitude <- map["lat"]
        longitude <- map["lng"]
    }
}
