//
//  ProfileViewController.swift
//  CallibriDemo
//
//  Created by aristarh on 23.11.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    lazy var label: UILabel = {
        let view = UILabel()
        view.text = "Profile VC"
        view.font = .systemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
