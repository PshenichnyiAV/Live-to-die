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
        label.text = "Рассчитай время смерти"
        label.font = UIFont.boldSystemFont (ofSize: 24)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var shapeView : UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "elipse")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
    
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
        
        view.backgroundColor = .gray
        startButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        setConstraints()
        
    }
    @objc func buttonPressed(){
        let rootVC = InfoPersonViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC,animated: true)
        
    }
 
}

extension TimeLeft {
    
    func setConstraints() {
        
        view.addSubview(shapeView)
        NSLayoutConstraint.deactivate([
            shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shapeView.heightAnchor.constraint(equalToConstant: 100),
            shapeView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
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
}


