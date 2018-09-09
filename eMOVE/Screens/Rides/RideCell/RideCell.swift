//
//  RideCell.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import UIKit
import Kingfisher

class RideCell: UITableViewCell {

    @IBOutlet var driverImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var delayLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    public func setupWith(_ ride: Direction) {
        if let imageResourceString = ride.user?.pictureUrl,
            let url = URL(string: imageResourceString) {
            self.driverImageView.kf.setImage(with: url)
        }
        self.nameLabel.text = ride.user?.name ?? ""
        self.phoneLabel.text = ride.user?.phone ?? ""
        self.delayLabel.text = ""
        self.timeLabel.text = ""
    }
    
}
