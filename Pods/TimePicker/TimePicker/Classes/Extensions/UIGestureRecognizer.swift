//
//  UIGestureRecognizer.swift
//  TimePicker
//
//  Created by Oleh Stasula on 15/05/2017.
//  Copyright © 2017 Oleh Stasula. All rights reserved.
//

import Foundation

extension UIGestureRecognizer {
    
    enum LocationType {
        case upper, lower
    }
    
    func locationType(in view: UIView) -> LocationType {
        return location(in: view).y < view.bounds.height / 2 ? .upper : .lower
    }
    
    func hasUpperLocationType(in view: UIView) -> Bool {
        return locationType(in: view) == .upper
    }
    
}
