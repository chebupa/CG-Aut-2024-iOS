//
//  ViewController.swift
//  BrainBitDemo
//
//  Created by Aseatari on 17.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "asd"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        setupButton()
    }
    
    func setupButton() {
        view.addSubview(button)
        
        button.setTitle("asd", for: .normal)
        button.setTitleColor(.systemPink, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 25
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
//        button.addTarget(self, action: #selector(goToTheNextScreen), for: .touchUpInside)
    }
    
//    @objc func goToTheNextScreen() {
//        let nextScreen = SecondViewController()
//        navigationController?.pushViewController(nextScreen, animated: true)
//    }
    

}

