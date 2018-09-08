//
//  Car.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper

public class Car {
    var registrationNumber: String?
    var extraInfo: String?
    var model: String?
    var seats: Int?
    var make: String?
    var color: String?
    
    required public init?(map: Map) {}
}

extension Car: Mappable {
    public func mapping(map: Map) {
        registrationNumber <- map["registration_number"]
        extraInfo <- map["extra_info"]
        model <- map["model"]
        seats <- map["seats"]
        make <- map["make"]
        color <- map["color"]
    }
}
