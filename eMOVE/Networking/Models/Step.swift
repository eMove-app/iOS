//
//  Step.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper

public class Step {
    var startLocation: StepLocation?
    var endLocation: StepLocation?
    
    required public init?(map: Map) {}
}

extension Step: Mappable {
    public func mapping(map: Map) {
        startLocation <- map["start_location"]
        endLocation <- map["end_location"]
    }
}
