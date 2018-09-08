//
//  Address.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper

public class Address {
    var addressId: Int?
    var latitude: Double?
    var longitude: Double?
    var name: String?
    var type: String?
    
    required public init?(map: Map) {}
}

extension Address: Mappable {
    public func mapping(map: Map) {
        addressId <- map["id"]
        latitude <- map["lat"]
        longitude <- map["lng"]
        name <- map["name"]
        type <- map["type"]
    }
}
