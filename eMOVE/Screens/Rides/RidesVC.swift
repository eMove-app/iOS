//
//  RidesVC.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import UIKit

protocol RidesVCDelegate: class {
    func ridesVCDidSelect(ride: Direction)
}

class RidesVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    public weak var delegate: RidesVCDelegate?
    
    public var rides: [Direction]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerReusableNibs(withClasses: [RideCell.self])
    }
}

extension RidesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.rides[indexPath.row]
        let cell = tableView.dequeueReusableCell(withClass: RideCell.self, for: indexPath)
        return cell
    }
}

extension RidesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.rides[indexPath.row]
        self.delegate?.ridesVCDidSelect(ride: item)
    }
}
