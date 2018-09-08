//
//  UserAgent.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import AssistantKit

class UserAgent {
    static func getUserAgent() -> String {
        if let info = Bundle.main.infoDictionary {
            let executable = info[kCFBundleExecutableKey as String] as? String ?? "Unknown"
            let appVersion = info["CFBundleShortVersionString"] as? String ?? "Unknown"
            let deviceType = Device.isPad ? "iPad" : "iPhone"
            return "\(executable)/\(appVersion) (\(deviceType); iOS \(UIDevice.current.systemVersion); Alamofire)"
        }
        return "Alamofire"
    }
}
