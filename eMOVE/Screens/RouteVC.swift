//
//  RouteVC.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import UIKit
import GoogleMaps
import Polyline

class RouteVC: UIViewController {

    @IBOutlet var mapView: GMSMapView!
    
    public var routeId: Int?
    public var direction: Direction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawPathsOnMap()
    }
    
    
    private func drawPathsOnMap()  {
        guard let direction = self.direction else { return }
        
        if let singlePolylineString = direction.singlePolyline,
            let singleCoordinates: [CLLocationCoordinate2D] = decodePolyline(singlePolylineString) {
            self.drawPathWith(singleCoordinates, color: .blue)
        }
        
        if let updatedPolyline = direction.updatedPolyline,
            let updatedCoordinates: [CLLocationCoordinate2D] = decodePolyline(updatedPolyline) {
            self.drawPathWith(updatedCoordinates, color: .red)
        }
        
        if let initialPolylineString = direction.initialPolyline,
            let initialCoordinates: [CLLocationCoordinate2D] = decodePolyline(initialPolylineString) {
            self.drawPathWith(initialCoordinates, color: .blue)
        }
        
    }

    private func drawPathWith(_ coordinates: [CLLocationCoordinate2D], color: UIColor) {
        let path = GMSMutablePath()
        let marker = GMSMarker()
        
        for coordinate in coordinates {
            path.add(CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude))
        }
        
        let rectangle = GMSPolyline(path: path)
        rectangle.strokeWidth = 5.0
        rectangle.strokeColor = color
        marker.map = mapView
        rectangle.map = mapView
        
        let loc: CLLocation = CLLocation(latitude: coordinates[0].latitude, longitude: coordinates[0].longitude)
        self.updateMapFrame(newLocation: loc, zoom: 15.0)
    }
    
    private func updateMapFrame(newLocation: CLLocation, zoom: Float) {
        let camera = GMSCameraPosition.camera(withTarget: newLocation.coordinate, zoom: zoom)
        self.mapView.animate(to: camera)
    }

}
