//
//  ViewController.swift
//  TestSDKSwift
//
//  Created by Aseatari on 29.11.2022.
//

import UIKit
import neurosdk2

class MainViewController: UIViewController {
    
    

    @IBOutlet var SearchButton: UIButton!
    @IBOutlet var DeviceInfoButton: UIButton!
    @IBOutlet var SignalButton: UIButton!
    @IBOutlet var EnvelopeButton: UIButton!
    
    
    //    @IBOutlet weak var SearchButton: UIButton!
//    @IBOutlet weak var DeviceInfoButton: UIButton!
//    @IBOutlet weak var SignalButton: UIButton!
//    @IBOutlet weak var EnvelopeButton: UIButton!
    
    @IBOutlet weak var PowerLabel: UIBarButtonItem!
    @IBOutlet weak var StateLabel: UIBarButtonItem!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.title = "Main"

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let controller = CallibriController.shared
        
        controller.connectionStateChanged = { (_ state : NTSensorState) -> Void in
            self.onStateChange(state: state)
        }
        
        controller.batteryChanged = {(_ power : NSNumber)  -> Void in
            self.onPowerChange(power: power)
        }
        
        self.onStateChange(state: controller.connectionState ?? NTSensorState.outOfRange)
    }
    
    func onPowerChange(power: NSNumber) {
        DispatchQueue.main.async {
            self.PowerLabel.title = power.stringValue + "%"
        }
    }
    
    func onStateChange(state: NTSensorState) {
        DispatchQueue.main.async {
            switch state {
            case .inRange:
                self.DeviceInfoButton.isEnabled = true
                self.SignalButton.isEnabled = true
                self.EnvelopeButton.isEnabled = true
                self.StateLabel.title = "Connected"
                break
            case .outOfRange:
                self.DeviceInfoButton.isEnabled = false
                self.SignalButton.isEnabled = false
                self.EnvelopeButton.isEnabled = false
                self.StateLabel.title = "Disconnected"
                self.PowerLabel.title = "0"
                break
            default:
                break
            }
        }
        
    }

}
