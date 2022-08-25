//
//  CountdowmViewController.swift
//  Play2Live
//
//  Created by Алексей on 14.08.2022.
//

import UIKit

class CountdownViewController : UIViewController {
    
    var personInfo: PersonInfo?{
        didSet {
            guard let personInfo = personInfo else { return }
            age = personInfo.allTime
            currentAge = personInfo.goneTime
            
        }
    }
    var age = 0
    var currentAge = 0
    
   lazy var progressBar: SRCountdownTimer = {
        let progressBar = SRCountdownTimer()
        progressBar.lineWidth = 5
        progressBar.lineColor = .green
        progressBar.trailLineColor = .red
        progressBar.labelTextColor = .black
        progressBar.labelFont = .preferredFont(forTextStyle: .title1)
        progressBar.backgroundColor = .white
        progressBar.timerFinishingText = "end"
        progressBar.useMinutesAndSecondsRepresentation = true
       progressBar.start(beginingValue: 24 * 60 * 60 * 365 * age, elapsedTime: TimeInterval(24 * 60 * 60 * 365 * currentAge) )// со скольки минут
        return progressBar
    }()
    
    let secondsLabel: UILabel = {
        let label = UILabel()
        label.text = "40"
        label.font = UIFont.boldSystemFont (ofSize: 24)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondsTextLabel: UILabel = {
        let secondsText = UILabel()
        secondsText.text = ": sec."
        secondsText.font = UIFont.boldSystemFont (ofSize: 24)
        secondsText.textColor = .white
        secondsText.numberOfLines = 0
        secondsText.textAlignment = .center
        secondsText.translatesAutoresizingMaskIntoConstraints = false
        return secondsText
    }()
    
    let minutesLabel : UILabel = {
        let minutes = UILabel()
        minutes.text = "15"
        minutes.font = UIFont.boldSystemFont (ofSize: 24)
        minutes.textColor = .white
        minutes.numberOfLines = 0
        minutes.textAlignment = .left
        minutes.translatesAutoresizingMaskIntoConstraints = false
        return minutes
    }()
    
    let minutesTextLabel : UILabel = {
        let minutesText = UILabel()
        minutesText.text = ": min."
        minutesText.font = UIFont.boldSystemFont (ofSize: 24)
        minutesText.textColor = .white
        minutesText.numberOfLines = 0
        minutesText.textAlignment = .center
        minutesText.translatesAutoresizingMaskIntoConstraints = false
        return minutesText
    }()
    
    var timer = Timer()
    var durationSeconds = 60
    var durationMinutes = 15
    
    override func viewDidLoad(){
        super.viewDidLoad()
         
        view.addSubview(progressBar)
        progressBar.frame = CGRect(x: 50, y: 100, width: 300, height: 300)
       // self.shapeView.rotate()
       // setConstraints()
        view.backgroundColor = .white
        startTimer()
        
    }
    // MARK: Start timer
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        durationSeconds -= 1
        secondsLabel.text = "\(durationSeconds)"
        //print(durationTimer)
        
        if durationMinutes == 0 {
            timer.invalidate()
        } else if durationSeconds == 0  {
            durationMinutes -= 1
            minutesLabel.text = "\(durationMinutes)"
            durationSeconds = 60
        }
    }
    
    // MARK: Set constraits
    
    func setConstraints() {
        
        view.addSubview(secondsTextLabel)// надпись секунд стр
        NSLayoutConstraint.activate([
            secondsTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            secondsTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            secondsTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        view.addSubview(secondsLabel)// количество секунд инт
        NSLayoutConstraint.activate([
            secondsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            secondsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(minutesLabel) // количество минут инт
        NSLayoutConstraint.activate([
            minutesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            minutesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            minutesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(minutesTextLabel)// надпись минут стр
        NSLayoutConstraint.activate([
            minutesTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            minutesTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            minutesTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])
        
    }
}


