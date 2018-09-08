//
//  SResponseError.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper

@objcMembers public class SResponseError: NSObject {
    fileprivate(set) var errorId: NSNumber?
    fileprivate(set) var key: String?
    var message: String!

    override init() {}
    required public init?(map: Map) { }
}

extension SResponseError: Mappable {
    public func mapping(map: Map) {
        errorId <- map["id"]
        key <- map["key"]
        message <- map["message"]
    }
}
