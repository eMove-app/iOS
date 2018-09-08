//
//  UserAPI.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper
import PromiseKit

class UserAPI {
    public class func loginWith(token: String, context: AnyObject) -> Promise<User> {
        return Promise { seal in
            APIProvider().request(target: UserTarget.loginWith(token: token,
                                                               context: context))
                .done { result in
                    if let data = result.data,
                        let response = Mapper<User>().map(JSONObject: data) {
                        seal.fulfill(response)
                    } else {
                        seal.reject(unformatedResponseError)
                    }
                }.catch { (error) in
                    seal.reject(error)
            }
        }
    }
    
    public class func userDetails(context: AnyObject) -> Promise<User> {
        return Promise { seal in
            APIProvider().request(target: UserTarget.userDetails(context: context))
                .done { result in
                    if let data = result.data,
                        let response = Mapper<User>().map(JSONObject: data) {
                        seal.fulfill(response)
                    } else {
                        seal.reject(unformatedResponseError)
                    }
                }.catch { (error) in
                    seal.reject(error)
            }
        }
    }
}
