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
    
    override func viewDidLoad(){
        super.viewDidLoad()
         
        view.addSubview(progressBar)
        progressBar.frame = CGRect(x: 50, y: 100, width: 300, height: 300)
        view.backgroundColor = .white
    }
    
}


