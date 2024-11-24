//
//  DeviceInfoViewController.swift
//  BrainBitExample
//
//  Created by Alexandr on 21.01.2021.
//

import UIKit

class DeviceInfoViewController: UIViewController {

    @IBOutlet weak var deviceInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        deviceInfoLabel.text = CallibriController.shared.fullInfo()
        
    }

}
