//
//  RideTarget.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import Moya

enum RideTarget {
    case create(input: RideDTO, context: AnyObject)
    case find(input: Coordinate, context: AnyObject)
}

extension RideTarget: Target {
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: apiURL)!
        }
    }
    
    public var path: String {
        switch self {
        case .create:
            return "rides/action/start"
        case .find:
            return "find-ride"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .create:
            return .post
        case .find:
            return .get
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        return JSONEncoding.default
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case let .create(input, _):
            return input.toJSONString()?.convertToDictionary()
         case let .find(input, _):
            return input.toJSONString()?.convertToDictionary()
        }
    }
    
    public var context: AnyObject {
        switch self {
        case let .create(_, context),
             let .find(_, context):
            return context
        }
    }
}
