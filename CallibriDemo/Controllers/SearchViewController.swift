//
//  SearchViewController.swift
//  NeuroDemoSwift
//
//  Created by Aseatari on 07.12.2022.
//

import UIKit
import neurosdk2

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CallibriController.shared.createAndConnect(sensorInfo: devices[indexPath.row], onConnectionResult: { state in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier: String = "DeviceInfoCell"

        let cell = self.availableDeviceTable.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)

        let devInfo = devices[indexPath.row]
        cell.textLabel?.text = devInfo.name
        cell.detailTextLabel?.text = devInfo.serialNumber;

        return cell;
    }
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var availableDeviceTable: UITableView!
    
    var searching: Bool = false
    var devices: [NTSensorInfo] = [NTSensorInfo]()
    
    @IBAction func startSearch(_ sender: UIButton) {
        searching = !searching
        if(searching){
            sender.setTitle("Stop", for: .normal)
            CallibriController.shared.startSearch(sensorsChanged: { sensors in
                self.devices.removeAll()
                self.devices.append(contentsOf: sensors)
                DispatchQueue.main.async {
                    self.availableDeviceTable.reloadData()
                }
            })
        }
        else
        {
            sender.setTitle("Start", for: .normal)
            CallibriController.shared.stpoSearch()
        }
    }
    
    override func viewDidLoad() {
        availableDeviceTable.delegate = self
        availableDeviceTable.dataSource = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        CallibriController.shared.stpoSearch()
    }
    
}
