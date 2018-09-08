//
//  LoginVC.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import SwiftyUserDefaults

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(_, _, let accessToken):
                UserAPI.loginWith(token: accessToken.authenticationToken, context: self)
                .done { response in
                    Defaults[.userLoggedId] = true
                    let storyboard = UIStoryboard(storyboard: .Main)
                    let homeTB = storyboard.instantiateInitialViewController()
                    UIApplication.shared.keyWindow?.rootViewController = homeTB
                }.catch { error in
                    print(error)
                }
            }
        }
    }
}
