//
//  LiveECGViewController.swift
//  CallibriDemo
//
//  Created by aristarh on 23.11.2024.
//

import UIKit
import SwiftUI
import neurosdk2

class LiveECGViewController: UIViewController {
    
    // MARK: - Views
    
    let signalViewController: SignalViewController = .init()
    
    lazy var toolbar: UIToolbar = {
        let view = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let connectButton = UIBarButtonItem(title: "Connect", style: .plain, target: self, action: #selector(connectButtonTapped))
        view.items = [flexibleSpace, connectButton, flexibleSpace]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var label: UILabel = {
        let view = UILabel()
        view.text = "Live ECG VC"
        view.font = .systemFont(ofSize: .init(16))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        constrain()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CallibriController.shared.connectionStateChanged = { (_ state: NTSensorState) -> Void in
            self.onStateChange(state: state)
        }
        CallibriController.shared.batteryChanged = { (_ power: NSNumber) -> Void in
            self.onPowerChange(power: power)
        }
        self.onStateChange(state: CallibriController.shared.connectionState ?? NTSensorState.outOfRange)
    }
    
    // MARK: - Setup
    
    private func setup() {
        view.addSubviews(toolbar, label, signalViewController.view)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setToolbarItems([.init(image: .init(systemName: "magnifyingglass"), style: .plain, target: nil, action: nil)], animated: false)
    }
    
    private func constrain() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
  
//            signalViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
//            signalViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            signalViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            signalViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension LiveECGViewController {
    
    @objc func connectButtonTapped() {
//        present(SearchDevicesViewController(), animated: true)
        present(UIHostingController(rootView: SearchState().screen), animated: true)
    }
    
    func onPowerChange(power: NSNumber) {
        DispatchQueue.main.async {
//            self.PowerLabel.title = power.stringValue + "%"
        }
    }
    
    func onStateChange(state: NTSensorState) {
        DispatchQueue.main.async {
            switch state {
            case .inRange:
                self.label.text = "Connected"
                self.navigationController?.pushViewController(SignalViewController(), animated: true)
                break
            case .outOfRange:
                self.label.text = "Disconected"
                break
            default:
                self.label.text = "Disconected"
                break
            }
        }
        
    }
}
