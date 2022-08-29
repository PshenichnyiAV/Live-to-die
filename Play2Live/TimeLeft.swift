//
//  ViewController.swift
//  Play2Live
//
//  Created by Алексей on 10.08.2022.
//

import UIKit

class TimeLeft: UIViewController {
    
    let lessonLabel : UILabel = {
        let label = UILabel()
        label.text = "Find out how much you have left"
        label.font = UIFont.boldSystemFont (ofSize: 24)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let startButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("CALCULATE", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setGradient()
        startButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        setConstraints()
        
    }
    @objc func buttonPressed(){
        let realmStorage = RealmStorage()
        let rootVC = InfoPersonViewController(storage: realmStorage)
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC,animated: true)
    }
}

extension TimeLeft {
    
    func setConstraints() {
        view.addSubview(lessonLabel)
        NSLayoutConstraint.activate([
            lessonLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            lessonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lessonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 70),
            startButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func setGradient() {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.cyan.cgColor, UIColor.purple.cgColor]
        layer.frame = view.bounds
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(layer, at: 0)
    }
    
}


