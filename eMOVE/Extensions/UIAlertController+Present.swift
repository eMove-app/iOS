//
//  UIAlertController+Present.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    func presentAlertWithTitle(title: String,
                               message: String,
                               okBlock: ((UIAlertAction) -> Swift.Void)? = nil,
                               context: AnyObject? = nil,
                               target: Target? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let viewController: UIViewController?
        if let context = context as? UIViewController {
            viewController = context
        } else {
            viewController = UIApplication.topViewController()
        }
        let completionBlock = okBlock
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: completionBlock)
        alert.addAction(action)
        viewController?.view.endEditing(true)

        viewController?.present(alert, animated: true, completion: nil)
    }
}

extension UIAlertController: UITextViewDelegate {
    
    func presentWith(okBlock: ((UIAlertAction) -> Swift.Void)? = nil,
                     cancelBlock: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = self
        let viewController = UIApplication.topViewController()
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: okBlock)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: cancelBlock)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        viewController?.view.endEditing(true)
        viewController?.present(alert, animated: true, completion: nil)
        
    }
}
