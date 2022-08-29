//
//  CountdowmViewController.swift
//  Play2Live
//
//  Created by Алексей on 14.08.2022.
//

import UIKit

class CountdownViewController : UIViewController {
    
    var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "no_eto_ne_ticnho")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let storage = RealmStorage()
    
    var progressBar: SRCountdownTimer = {
        let progressBar = SRCountdownTimer()
        progressBar.lineWidth = 5
        progressBar.lineColor = .green
        progressBar.trailLineColor = .red
        progressBar.labelTextColor = .black
        progressBar.labelFont = .preferredFont(forTextStyle: .title1)
        progressBar.backgroundColor = .white
        progressBar.timerFinishingText = "end"
        progressBar.useMinutesAndSecondsRepresentation = true
       
        return progressBar
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        checkUserDefault()
        addConstraints()
        view.backgroundColor = .white
      
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let data = loadData()
        progressBar.start(beginingValue: 24 * 60 * 60 * 365 * data.allTime, elapsedTime: TimeInterval(24 * 60 * 60 * 365 * data.goneTime) )// со скольки минут
    }
    
    func loadData() -> UserData {
        guard let data = storage.load() else { return UserData(restTime: 0, goneTime: 0, gender: .male, continent: .europe) }
       return data
    }
    
    func addConstraints() {
        view.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressBar.heightAnchor.constraint(equalTo: progressBar.widthAnchor, multiplier: 1/1) // в зависимотси от экрана
        ])
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func checkUserDefault() {
        guard !UserDefaults.standard.bool(forKey: "chek") else { return }
        UserDefaults.standard.set(true, forKey: "chek")
    }
    
}



