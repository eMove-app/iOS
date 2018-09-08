//
//  APINotification.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper

@objcMembers class APINotifications: NSObject {
    var error: [SResponseError]?
    var warning: [SResponseError]?
    var infoUnfilered: [SResponseError]?
    var success: [SResponseError]?
    required init?(map: Map) {}
}

extension APINotifications: Mappable {
    func mapping(map: Map) {
        error <- map["error"]
        warning <- map["warning"]
        infoUnfilered <- map["info"]
        success <- map["success"]
    }
}
