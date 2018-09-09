//
//  BaseService.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import Simple_KeychainSwift

let APIManager = MoyaProvider<GenericTarget>(endpointClosure: endpointClosure,
                                            requestClosure: requestClosure,
                                            manager: manager,
                                            plugins: [NetworkLoggerPlugin(verbose: false,
                                                                          cURL: true,
                                                                          responseDataFormatter: JSONFormatter)])
let manager = Manager(
    configuration: URLSessionConfiguration.default,
    serverTrustPolicyManager: TrustPolicyManager()
)

let endpointClosure = { (target: GenericTarget) -> Endpoint in

    let endpoint = APIEndpoint(
        url: url(target: target),
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: target.task,
        httpHeaderFields: headers(target: target),
        requestTimeout: target.requestTimeout
    )
    return endpoint
}

let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    guard let apiEndpoint = endpoint as? APIEndpoint,
        var request: URLRequest = try? apiEndpoint.urlRequest() else { return }
    request.timeoutInterval = apiEndpoint.requestTimeout
    request.cachePolicy = .reloadIgnoringLocalCacheData
    request.httpShouldHandleCookies = false
    done(.success(request))
}

private func headers(target: GenericTarget) -> [String: String] {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    var headers = ["X-App-Version": "iOS-" + appVersion]
    headers.updateValue(getToken(), forKey: "X-Token")
    headers.updateValue(UserAgent.getUserAgent(), forKey: "User-Agent")
    headers.updateValue("mobile-app", forKey: "X-Request-Source")
    return headers
}

private func getToken() -> String {
    return Keychain.value(forKey: kUserToken) ?? ""
}

private func url(target: GenericTarget) -> String {
    var url = target.baseURL.appendingPathComponent(target.path).absoluteString
    if let paramaters = target.queryURLParameters {
        for (entry) in paramaters {
            url += "&" + entry.key + "=" + entry.value
        }
    }
    return url
}

private func JSONFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}
