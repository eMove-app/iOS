//
//  User.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper

public class User {
    var email: String?
    var pictureUrl: String?
    var uuid: String?
    var created: Bool?
    var name: String?
    var car: Car?
    var phone: String?
    var leavesFromHome: String?
    var addresses: [Address]?
    var workAddresses: [Address]? {
        guard let addresses = self.addresses else { return nil }
        return addresses.filter({$0.type == "work"})
    }
    var homeAddress: [Address]? {
        guard let addresses = self.addresses else { return nil }
        return addresses.filter({$0.type == "home"})
    }
    
    required public init?(map: Map) {}
}

extension User: Mappable {
    public func mapping(map: Map) {
        email <- map["email"]
        pictureUrl <- map["profile_picture_url"]
        uuid <- map["uuid"]
        created <- map["created"]
        name <- map["name"]
        car <- map["car"]
        addresses <- map["addresses"]
        phone <- map["phone"]
        leavesFromHome <- map["leaves_from_home"]
    }
}
