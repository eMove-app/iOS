//
//  HomeVC.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func getCreateOrRideVC() ->  CreateOrFindRideVC {
        let storyboard = UIStoryboard(storyboard: .CreateOrFindRide)
        let createOrFindRideVC: CreateOrFindRideVC = storyboard.instantiateViewController()
        return createOrFindRideVC
    }

    @IBAction func createRideButtonPressed(_ sender: UIButton) {
        let createOrFindRideVC = self.getCreateOrRideVC()
        self.navigationController?.pushViewController(createOrFindRideVC, animated: true)
    }
    
    @IBAction func findRideButtonPressed(_ sender: UIButton) {
        let createOrFindRideVC = self.getCreateOrRideVC()
        createOrFindRideVC.findRideMode = true
        self.navigationController?.pushViewController(createOrFindRideVC, animated: true)
    }
}
