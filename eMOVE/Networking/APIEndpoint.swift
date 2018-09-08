//
//  APIEndpoint.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import Moya

class APIEndpoint: Endpoint {
    public var requestTimeout: Double
    
    public init(url: String,
                sampleResponseClosure: @escaping SampleResponseClosure,
                method: Moya.Method = Moya.Method.get,
                task: Task,
                httpHeaderFields: [String: String]? = nil,
                requestTimeout: Double = 0.0) {
        self.requestTimeout = requestTimeout
        super.init(url: url,
                   sampleResponseClosure: sampleResponseClosure,
                   method: method,
                   task: task,
                   httpHeaderFields: httpHeaderFields)
    }
}
