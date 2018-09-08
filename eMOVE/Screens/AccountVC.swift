//
//  AccountVC.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyUserDefaults

class AccountVC: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet var homeAddressLabel: UITextField!
    @IBOutlet var workAddressLabel: UITextField!
    @IBOutlet var phoneNumberLabel: UITextField!
    @IBOutlet var brandLabel: UITextField!
    @IBOutlet var colorLabel: UITextField!
    @IBOutlet var registerNumberLabel: UITextField!
    @IBOutlet var seatsLabel: UITextField!
    @IBOutlet var observationsLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentView.isHidden = true
        UserAPI.userDetails(context: self)
            .done { user in
                self.contentView.isHidden = false
                self.setupWith(user)
            }.catch { error in
                print(error)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvează",
                                                                 style: .plain,
                                                                 target: self, action: #selector(saveButtonPressed))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out",
                                                                style: .plain,
                                                                target: self, action: #selector(signOutButtonPressed))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupWith(_ user: User) {
        if let imageResourceString = user.pictureUrl,
            let url = URL(string: imageResourceString) {
            self.imageView.kf.setImage(with: url)
        }
        self.nameLabel.text = user.name
        self.homeAddressLabel.text = user.homeAddress?.first?.name
        self.workAddressLabel.text = user.workAddresses?.first?.name
        self.phoneNumberLabel.text = user.phone
        self.brandLabel.text = user.car?.make
        self.colorLabel.text = user.car?.color
        self.registerNumberLabel.text = user.car?.registrationNumber
        self.seatsLabel.text = "\(user.car?.seats ?? 3)"
        self.observationsLabel.text = user.car?.extraInfo
    }
    
    @objc fileprivate func saveButtonPressed() {}
    
    @objc fileprivate func signOutButtonPressed() {
        Defaults[.userLoggedId] = false
        let storyboard = UIStoryboard(storyboard: .Login)
        let loginVC: LoginVC = storyboard.instantiateViewController()
        UIApplication.shared.keyWindow?.rootViewController = loginVC
    }
}
