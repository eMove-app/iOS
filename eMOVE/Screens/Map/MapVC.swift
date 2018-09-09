//
//  MapVC.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import UIKit
import GoogleMaps
import FirebaseDatabase

protocol MapVCDelegate: class {
    func mapVCDidUpdateTo(address: GMSAddress, pickType: PickType?)
}

enum PickType {
    case pickup
    case destination
}

class MapVC: UIViewController {

    @IBOutlet var addressLabel: UILabel!
    @IBOutlet private weak var pinImageVerticalConstraint: NSLayoutConstraint!
    @IBOutlet var mapView: GMSMapView!
    
    public weak var delegate: MapVCDelegate?
    public var pickType: PickType?
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.mapView.delegate = self
        
        let ref = Database.database().reference(withPath: "grocery-items")
        
        ref.observe(.value, with: { snapshot in
            print(snapshot.value as Any)
        })
    }
    
    fileprivate func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()

        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            
            self.delegate?.mapVCDidUpdateTo(address: address, pickType: self.pickType)
            self.addressLabel.unlock()
            self.addressLabel.text = lines.joined(separator: "\n")
            
            let labelHeight = self.addressLabel.intrinsicContentSize.height
            self.mapView.padding = UIEdgeInsets(top: self.view.safeAreaInsets.top, left: 0,
                                                bottom: labelHeight, right: 0)
            
            UIView.animate(withDuration: 0.25) {
                self.pinImageVerticalConstraint.constant = ((labelHeight - self.view.safeAreaInsets.top) * 0.5)
                self.view.layoutIfNeeded()
            }
        }
    }

}

extension MapVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        self.locationManager.startUpdatingLocation()

        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = true
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        self.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        self.locationManager.stopUpdatingLocation()
    }
}


extension MapVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.reverseGeocodeCoordinate(position.target)
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.addressLabel.lock()
    }
}
