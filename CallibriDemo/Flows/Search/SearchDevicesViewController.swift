////
////  SearchViewController.swift
////  CallibriDemo
////
////  Created by aristarh on 24.11.2024.
////
//
//import UIKit
//import neurosdk2
//
//class SearchDevicesViewController: UIViewController {
//    
//    // MARK: - Properties
//    
//    var searching: Bool = false
//    var devices: [NTSensorInfo] = [NTSensorInfo]()
//    
//    // MARK: - Views
//    
//    lazy var availableDeviceTable: UITableView = {
//        let view = UITableView(frame: .zero, style: .plain)
//        view.dataSource = self
//        view.delegate = self
//        view.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    lazy var stackView: UIStackView = {
//        let view = UIStackView()
//        view.axis = .vertical
//        view.spacing = 16
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    // MARK: - VC Lifecycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//        constrain()
////        self.updateLayout(with: self.view.frame.size)
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        CallibriController.shared.stpoSearch()
//    }
//    
////    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
////        super.viewWillTransition(to: size, with: coordinator)
////        coordinator.animate { context in
////            self.updateLayout(with: size)
////        }
////    }
//    
//    // MARK: - Setup
//    
//    private func setup() {
//        view.backgroundColor = .systemBackground
//        view.addSubview(stackView)
//        
////        view.addSubviews(availableDeviceTable)
//        startSearch()
//    }
//    
//    private func constrain() {
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: view.topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            
////            availableDeviceTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
////            availableDeviceTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
////            availableDeviceTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
////            availableDeviceTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//    }
//    
//    private func updateLayout(with size: CGSize) {
//        availableDeviceTable.frame = CGRect.init(origin: .zero, size: size)
//    }
//    
//    // MARK: - Methods
//    
//    func startSearch() {
////        searching = !searching
////        if searching {
//            CallibriController.shared.startSearch(sensorsChanged: { sensors in
//                self.devices.removeAll()
//                self.devices.append(contentsOf: sensors)
//                
//                for sensor in sensors {
//                    let label = UILabel()
//                    label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(connectTo))
//                    label.text = sensor.name
//                    self.stackView.addArrangedSubview(label)
//                }
//                
//                DispatchQueue.main.async {
//                    self.availableDeviceTable.reloadData()
//                }
//            })
////        } else {
////            CallibriController.shared.stpoSearch()
////        }
//    }
//    
//    @objc func connectTo(_ gesture: UITapGestureRecognizer) {
//        guard let label = gesture.view as? UILabel else { return }
//
//        CallibriController.shared.createAndConnect(sensorInfo: , onConnectionResult: { state in
//            DispatchQueue.main.async {
//                self.navigationController?.popViewController(animated: true)
//            }
//        })
//    }
//}
//
//// MARK: - UITableViewDataSource
//
//extension SearchDevicesViewController: UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return devices.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellIdentifier: String = "DeviceInfoCell"
//        let cell = self.availableDeviceTable.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
//        
//        let devInfo = devices[indexPath.row]
//        cell.textLabel?.text = devInfo.name
//        cell.detailTextLabel?.text = devInfo.serialNumber;
//        
//        return cell;
//    }
//}
//
//// MARK: - UITableViewDelegate
//
//extension SearchDevicesViewController: UITableViewDelegate {
// 
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        CallibriController.shared.createAndConnect(sensorInfo: devices[indexPath.row], onConnectionResult: { state in
//            DispatchQueue.main.async {
//                self.navigationController?.popViewController(animated: true)
//            }
//        })
//    }
//}
//
