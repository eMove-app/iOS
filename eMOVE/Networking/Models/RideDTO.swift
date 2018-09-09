//
//  RideDTO.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper

public class RideDTO {
    var startPoint: Coordinate?
    var endPoint: Coordinate?
    var startTime: String?
    
    init(startPoint: Coordinate, endPoint: Coordinate, startTime: String) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.startTime = startTime
    }
    
    required public init?(map: Map) {}
}

extension RideDTO: Mappable {
    public func mapping(map: Map) {
        startPoint <- map["start_point"]
        endPoint <- map["end_point"]
        startTime <- map["start_time"]
    }
}
