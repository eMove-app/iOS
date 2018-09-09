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
    public class func create(_ input: RideDTO, context: AnyObject) -> Promise<Direction> {
        return Promise { seal in
            APIProvider().request(target: RideTarget.create(input: input,
                                                            context: context))
                .done { result in
                    if let data = result.data,
                        let response = Mapper<Direction>().map(JSONObject: data) {
                        seal.fulfill(response)
                    } else {
                        seal.reject(unformatedResponseError)
                    }
                }.catch { (error) in
                    seal.reject(error)
            }
        }
    }
    
    public class func find(_ input: Coordinate, context: AnyObject) -> Promise<[Direction]> {
        return Promise { seal in
            APIProvider().request(target: RideTarget.find(input: input,
                                                          context: context))
                .done { result in
                    if let data = result.data,
                        let array = Mapper<Direction>().mapArray(JSONObject: data) {
                        seal.fulfill(array)
                    } else {
                        seal.reject(unformatedResponseError)
                    }
                }.catch { (error) in
                    seal.reject(error)
            }
        }
    }
}
