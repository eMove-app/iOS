//
//  StepLocation.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper

public class StepLocation {
    var latitude: Double?
    var longitude: Double?
    
    required public init?(map: Map) {}
}

extension StepLocation: Mappable {
    public func mapping(map: Map) {
        latitude <- map["lat"]
        longitude <- map["lng"]
    }
}
