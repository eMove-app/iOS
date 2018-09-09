//
//  RideAPI.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import ObjectMapper
import PromiseKit

class RideAPI {
    public class func create(_ input: RideDTO, context: AnyObject) -> Promise<Int> {
        return Promise { seal in
            APIProvider().request(target: RideTarget.create(input: input,
                                                            context: context))
                .done { result in
                    if let response = result.data as? [String: Int],
                        let tripId = response["id"] {
                        seal.fulfill(tripId)
                    } else {
                        seal.reject(unformatedResponseError)
                    }
                }.catch { (error) in
                    seal.reject(error)
            }
        }
    }
    
    public class func find(_ input: Coordinate, context: AnyObject) -> Promise<Int> {
        return Promise { seal in
            APIProvider().request(target: RideTarget.find(input: input,
                                                          context: context))
                .done { result in
                    if let response = result.data as? [String: Int],
                        let tripId = response["id"] {
                        seal.fulfill(tripId)
                    } else {
                        seal.reject(unformatedResponseError)
                    }
                }.catch { (error) in
                    seal.reject(error)
            }
        }
    }
}
