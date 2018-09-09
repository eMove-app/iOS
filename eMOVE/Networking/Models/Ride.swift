//
//  Ride.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper

public class Ride {
    var rideId: Int?
    var initial: Double?
    var updated: Double?
    var user: User?
    
    required public init?(map: Map) {}
}

extension Ride: Mappable {
    public func mapping(map: Map) {
        rideId <- map["id"]
        initial <- map["initial.directions"]
        updated <- map["updated.directions"]
        user <- map["user"]
    }
}
