//
//  APIResponse.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper

@objcMembers public class APIResponse: NSObject {
    var code: Int = 0
    var status: String?
    var data: Any?
    var notifications: APINotifications?
    var apiVersion: String?
    var token: String?
    
    init(data: Any?) {
        self.data = data
    }
    
    required public init?(map: Map) {}
}

extension APIResponse: Mappable {
    public func mapping(map: Map) {
        code <- map["code"]
        status <- map["status"]
        data <- map["data"]
        notifications <- map["notifications"]
        apiVersion <- map["apiVersion"]
        token <- map["token"]
    }
}
