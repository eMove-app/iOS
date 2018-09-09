//
//  Leg.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper

public class Leg {
    var steps: [Step]?
    
    required public init?(map: Map) {}
}

extension Leg: Mappable {
    public func mapping(map: Map) {
        steps <- map["steps"]
    }
}
