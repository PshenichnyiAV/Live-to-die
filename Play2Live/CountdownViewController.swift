//
//  CountdowmViewController.swift
//  Play2Live
//
//  Created by Алексей on 14.08.2022.
//

import UIKit

class CountdownViewController : UIViewController {
    
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
        UserDefaults.standard.set(true, forKey: "chek")
        
        view.addSubview(progressBar)
        progressBar.frame = CGRect(x: 50, y: 100, width: 300, height: 300)
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
    
}



