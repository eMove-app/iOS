//
//  CreateRideVC.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import UIKit
import GoogleMaps
import NVActivityIndicatorView

class CreateOrFindRideVC: UIViewController, NVActivityIndicatorViewable {

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
        self.createRideButton.setTitle(self.findRideMode ? "Find Ride" : "Create Ride", for: .normal)
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
        self.departureTime = Date()
        self.updateLayout()
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
        guard let pickupAddress = self.pickupAddress,
            let destinationAddress = self.destinationAddress,
            let departureTime = self.departureTime else { return }
        
        sender.isUserInteractionEnabled = false
        let size = CGSize(width: 30, height: 30)
        self.startAnimating(size,
                            message: "Loading...",
                            type: NVActivityIndicatorType(rawValue: sender.tag)!,
                            fadeInAnimation: nil)
        if self.findRideMode {
            let endPoint = Coordinate(latitude: destinationAddress.coordinate.latitude,
                                        longitude: destinationAddress.coordinate.longitude)
            RideAPI.find(endPoint, context: self)
                .done { response in
                    if response.isEmpty {
                        UIAlertController().presentAlertWithTitle(title: "",
                                                                  message: "No rides found",
                                                                  okBlock: nil,
                                                                  context: nil)
                        return
                    }
                    let storyboard = UIStoryboard(storyboard: .Rides)
                    let ridesVC: RidesVC = storyboard.instantiateViewController()
                    ridesVC.rides = response
                    ridesVC.delegate = self
                    self.navigationController?.pushViewController(ridesVC, animated: true)
                }.ensure {
                    sender.isUserInteractionEnabled = true
                    self.stopAnimating(nil)
                }.catch { error in
                    print(error)
                }
        } else {
            let startPoint = Coordinate(latitude: pickupAddress.coordinate.latitude, longitude: pickupAddress.coordinate.longitude)
            let endPoint = Coordinate(latitude: destinationAddress.coordinate.latitude, longitude: destinationAddress.coordinate.longitude)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm:ss"
            let startTime = formatter.string(from: departureTime)
            let input = RideDTO(startPoint: startPoint, endPoint: endPoint, startTime: startTime)

            RideAPI.create(input, context: self)
            .done { response in
                let storyboard = UIStoryboard(storyboard: .Route)
                let routeVC: RouteVC = storyboard.instantiateViewController()
                routeVC.direction = response
                self.navigationController?.pushViewController(routeVC, animated: true)
            }.ensure {
                sender.isUserInteractionEnabled = true
                self.stopAnimating(nil)
            }.catch { error in
                print(error)
            }
        }
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


extension CreateOrFindRideVC: RidesVCDelegate {
    func ridesVCDidSelect(ride: Direction) {
        let storyboard = UIStoryboard(storyboard: .Route)
        let routeVC: RouteVC = storyboard.instantiateViewController()
        routeVC.direction = ride
        self.navigationController?.pushViewController(routeVC, animated: true)
    }
}
