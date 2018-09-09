//
//  CreateRideVC.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import UIKit
import GoogleMaps

class CreateOrFindRideVC: UIViewController {

    @IBOutlet var timePickerView: UIView!
    @IBOutlet var createRideButton: UIButton!
    @IBOutlet var pickupPointValueLabel: PaddingLabel!
    @IBOutlet var destinationValueLabel: PaddingLabel!
    @IBOutlet var timeValueLabel: PaddingLabel!
    
    public var findRideMode = false
    
    private var pickupAddress: GMSAddress?
    private var destinationAddress: GMSAddress?
    private var departureTime: Date?
    
    override func viewDidLoad() {
        self.createRideButton.isEnabled = false
        self.timePickerView.alpha = 0
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func updateLayout() {
        if let pickupAddressString = self.pickupAddress?.lines?.first {
            self.pickupPointValueLabel.text = pickupAddressString
        }
        if let destinationAddressString = self.destinationAddress?.lines?.first {
            self.destinationValueLabel.text = destinationAddressString
        }
        if let departureTime = self.departureTime {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            let hourString = formatter.string(from: departureTime)
            self.timeValueLabel.text = hourString
        }

        self.createRideButton.isEnabled = (self.pickupAddress != nil &&
            self.destinationAddress != nil && self.departureTime != nil)
    }
    
    private func getMapVC() -> MapVC {
        let storyboard = UIStoryboard(storyboard: .Map)
        let mapVC: MapVC = storyboard.instantiateViewController()
        mapVC.delegate = self
        return mapVC
    }
    
    @IBAction func pickPickupButtonPressed(_ sender: UIButton) {
        let mapVC = self.getMapVC()
        mapVC.pickType = .pickup
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @IBAction func pickDestinationButtonPressed(_ sender: UIButton) {
        let mapVC = self.getMapVC()
        mapVC.pickType = .destination
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @IBAction func pickTimeButtonPressed(_ sender: UIButton) {
        self.timePickerView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.timePickerView.alpha = 1.0
        }
    }
    
    @IBAction func dismissPickerTimeButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.timePickerView.alpha = 0
        }) { finished in
            self.timePickerView.isHidden = true
        }
    }
    
    @IBAction func timePickerValueChanged(_ sender: UIDatePicker) {
        self.departureTime = sender.date
        self.updateLayout()
    }
    
    @IBAction func createRideButtonPressed(_ sender: UIButton) {

    }
}

extension CreateOrFindRideVC: MapVCDelegate {
    func mapVCDidUpdateTo(address: GMSAddress, pickType: PickType?) {
        if pickType == .pickup {
            self.pickupAddress = address
        } else {
            self.destinationAddress = address
        }
        self.updateLayout()
    }
}
