//
//  MultiTarget.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import Moya
import SwiftyUserDefaults

public protocol Target: TargetType {
    var queryURLParameters: [String: String]? { get }
    var httpHeaders: [String: String]? { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var requestTimeout: Double { get }
    var displayAPIErrors: Bool { get }
    var shouldValidateResponse: Bool { get }
    var context: AnyObject { get }
    var responseIsFormatted: Bool { get }
}

public extension Target {
    public var sampleData: Data { return Data() }
    
    public var shouldValidateResponse: Bool { return true }
    
    public var queryURLParameters: [String: String]? { return nil }
    
    public var httpHeaders: [String: String]? { return nil }
    
    public var headers: [String: String]? { return nil }
    
    public var parameters: [String: Any]? { return nil }
    
    public var requestTimeout: Double { return 15.0 }
    
    public var displayAPIErrors: Bool { return true }
    
    public var task: Task { return .requestPlain }
    
    public var parameterEncoding: Moya.ParameterEncoding { return URLEncoding.default }
    
    public var responseIsFormatted: Bool { return true }
    
    public var shouldBlockInterface: Bool { return self.method != .get }
}

public enum GenericTarget: Target {
    
    case target(Target)
    
    public init(_ target: Target) {
        self = GenericTarget.target(target)
    }
    
    public var path: String {
        return target.path
    }
    
    public var baseURL: URL {
        return target.baseURL
    }
    
    public var method: Moya.Method {
        return target.method
    }
    
    public var httpHeaders: [String: String]? {
        return target.httpHeaders
    }
    
    public var headers: [String: String]? {
        return target.headers
    }
    
    public var parameters: [String: Any]? {
        return target.parameters
    }
    
    public var queryURLParameters: [String: String]? {
        return target.queryURLParameters
    }
    
    public var parameterEncoding: Moya.ParameterEncoding {
        return target.parameterEncoding
    }
    
    public var task: Task {
        guard let parameters = target.parameters else { return .requestPlain }
        return .requestParameters(parameters: parameters, encoding: target.parameterEncoding)
    }
    
    public var context: AnyObject {
        return target.context
    }

    public var target: Target {
        switch self {
        case .target(let tar): return tar
        }
    }
    
    public var responseIsFormatted: Bool {
        return target.responseIsFormatted
    }
    
    public var requestTimeout: Double {
        return target.requestTimeout
    }
}
