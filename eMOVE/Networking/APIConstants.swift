//
//  APIConstants.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import Moya
import SwiftyUserDefaults

extension DefaultsKeys {
    static let userLoggedId = DefaultsKey<Bool>("user_logged_in")
}

let kUserToken = "userToken"
let googleApiKey = "AIzaSyAUYo-VTQsOoMS8HWTppA6Jn0ZBFVJEa5E"

var apiURL: String {
    return "http://167.99.32.81:5000/"
}

let unformatedResponseError = NSError(domain: "com.danteinternational.emove",
                                      code: 0,
                                      userInfo: [NSLocalizedDescriptionKey: "Wrong response format"])
let functionalityUnavailableError = NSError(domain: "com.danteinternational.emove",
                                            code: 1,
                                            userInfo: [NSLocalizedDescriptionKey:
                                                "Functionality currently unavailable"])
let serverError = NSError(domain: "Server error",
                          code: 2,
                          userInfo: [NSLocalizedDescriptionKey: "Server error"])

let cryptedResponseError = NSError(domain: "com.danteinternational.emove",
                                   code: 3,
                                   userInfo: [NSLocalizedDescriptionKey: "Response cannot be decrypted"])
let resourceNotFoundError = NSError(domain: "com.danteinternational.emove",
                                   code: 4,
                                   userInfo: [NSLocalizedDescriptionKey: "Resource not found"])
