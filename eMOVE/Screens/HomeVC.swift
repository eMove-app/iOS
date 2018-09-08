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

    @IBAction func createRideButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(storyboard: .CreateRide)
        let createRideVC: CreateRideVC = storyboard.instantiateViewController()
        self.navigationController?.pushViewController(createRideVC, animated: true)
    }
    
    @IBAction func findRideButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(storyboard: .FindRide)
        let findRideVC: FindRideVC = storyboard.instantiateViewController()
        self.navigationController?.pushViewController(findRideVC, animated: true)
    }
}
