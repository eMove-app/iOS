//
//  PinPoint.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper

public class PinPoint {
    var pinId: Int?
    var latitude: Double?
    var longitude: Double?
    var pinType: String?
    var user: User?
    
    required public init?(map: Map) {}
}

extension PinPoint: Mappable {
    public func mapping(map: Map) {
        pinId <- map["id"]
        latitude <- map["lat"]
        longitude <- map["lng"]
        pinType <- map["type"]
        user <- map["user"]
    }
}
