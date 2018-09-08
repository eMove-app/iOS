//
//  MoyaProvider+Promise..swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import PromiseKit
import Moya

public extension MoyaProvider {
    public typealias ResultPromise = Promise<Moya.Response>

    public func requestPromise(target: Target,
                               queue: DispatchQueue? = nil,
                               progress: Moya.ProgressBlock? = nil) -> ResultPromise {
        return requestPromiseWithCancellable(target: target,
                                             queue: queue,
                                             progress: progress).promise
    }

    func requestPromiseWithCancellable(target: Target,
                                       queue: DispatchQueue?,
                                       progress: Moya.ProgressBlock? = nil) -> (promise: ResultPromise,
                                                                                cancellable: Cancellable) {
        let pending = ResultPromise.pending()
        return (
            pending.promise,
            self.request(target,
                         callbackQueue: queue,
                         progress: progress,
                         completion: self.promiseCompletion(fulfill: pending.resolver.fulfill,
                                                            reject: pending.resolver.reject))
        )
    }

    private func promiseCompletion(fulfill: @escaping (Moya.Response) -> Void,
                                   reject: @escaping (Swift.Error) -> Void) -> Moya.Completion {
        return { result in
            switch result {
            case let .success(response):
                fulfill(response)
            case let .failure(error):
                reject(error)
            }
        }
    }

}
