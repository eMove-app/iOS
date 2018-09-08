//
//  APIProvider.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import Moya
import Result
import Reachability
import Simple_KeychainSwift
import ObjectMapper
import PromiseKit

private enum ErrorCodes: Int {
    case timeout = -1009
}

public class APIProvider: NSObject {
    public func request(target: Target) -> Promise<APIResponse> {
        return Promise { seal in
            if Reachability()!.connection == .none {
                seal.reject(serverError)
                return
            }
            firstly {
                APIManager.requestPromise(target: GenericTarget(target))
            }.done { result in
                if !target.responseIsFormatted {
                    seal.fulfill(self.formattedResponse(data: result.data))
                    return
                }
                
                guard let apiResponse = self.decryptResponse(data: result.data,
                                                           baseURL: target.baseURL.absoluteString) else {
                    seal.reject(cryptedResponseError)
                    return
                }
                
                self.saveUserToken(token: apiResponse.token)
                let isValid = self.validate(response: apiResponse, target: target)
                if target.shouldValidateResponse && !isValid {
                    seal.reject(serverError)
                } else {
                    seal.fulfill(apiResponse)
                }
            }.catch { error in
                self.handle(serverError: error as NSError, target: target)
                seal.reject(error)
            }
        }
    }
}

extension APIProvider {
    fileprivate func formattedResponse(data: Data) -> APIResponse {
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        let apiResponse = APIResponse(data: json)
        return apiResponse
    }
    
    fileprivate func decryptResponse(data: Data, baseURL: String) -> APIResponse? {
        if let responseString = String(data: Data(data), encoding: .utf8) {
            return APIResponse(JSONString: responseString)
        } else {
            return nil
        }
    }
    
    fileprivate func validate(response: APIResponse, target: Target) -> Bool {
        if response.code < 400 { return true }
        if let message = response.notifications?.error?.first?.message,
            target.displayAPIErrors {
            UIAlertController().presentAlertWithTitle(title: "",
                                                      message: message,
                                                      okBlock: nil,
                                                      context: target.context)
        }
        return false
    }
    
    fileprivate func saveUserToken(token: String?) {
        if let unwrappedToken = token {
            _ = Keychain.set(unwrappedToken, forKey: kUserToken)
        }
    }
}

extension APIProvider {
    fileprivate func handle(serverError: NSError?, target: Target) {
        guard let error = serverError  else { return }
        print(error.code)
    }
}
