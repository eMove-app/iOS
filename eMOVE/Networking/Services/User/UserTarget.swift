//
//  UserTarget.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import Moya

enum UserTarget {
    case loginWith(token: String, context: AnyObject)
    case userDetails(context: AnyObject)
}

extension UserTarget: Target {
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: apiURL)!
        }
    }
    
    public var path: String {
        switch self {
        case .loginWith:
            return "login"
        case .userDetails:
            return "me"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .loginWith:
            return .post
        case .userDetails:
            return .get
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case let .loginWith(token, _):
            return ["token": token]
        default:
            return nil
        }
    }
    
    public var context: AnyObject {
        switch self {
        case let .loginWith(_, context),
             let .userDetails(context):
            return context
        }
    }
}
