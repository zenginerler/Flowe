//
//  HomeViewController.swift
//  flowe
//
//  Created by Yixing Ma on 11/8/21.
//

import UIKit
import CoreData
import EventKit
class Pomodoro {
    var num = 0
}

class HomeViewController: UIViewController {
    var timer = Timer()
    var seconds = 10
    var pomo: Pomodoro?
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var RemainTimeLabel: UILabel!
    @IBOutlet weak var numPomoLabel: UILabel!
    var work: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func calendarButtonPress(_ sender: Any) {
        guard let url = URL(string: "calshow://") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func startButton(_ sender: Any) {
        seconds = 10
        timer.invalidate()
        statusLabel.backgroundColor = UIColor .red
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(HomeViewController.timerClass), userInfo: nil, repeats: true)
        
        if seconds == 0 {
//            statusLabel.backgroundColor = UIColor .green
//            self.pomo.num += 1
//            numPomoLabel.text = String(self.pomo.num)
        }
        
    }
    
    
    @IBAction func breakButton(_ sender: Any) {
        seconds = 5 
        timer.invalidate()
        statusLabel.backgroundColor = UIColor .green
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(HomeViewController.timerClass), userInfo: nil, repeats: true)
        
    
    }
    
    @objc func timerClass() {
        seconds -= 1
        RemainTimeLabel.text = String(seconds)
        if seconds == 0 {
            timer.invalidate()
            if work == true {
                statusLabel.backgroundColor = UIColor .green
                work = false
                self.pomo?.num += 1
                print("pomonum", self.pomo?.num)
                
            }
            else {
                statusLabel.backgroundColor = UIColor .red
                work = true
            }
        }
    }
    
    
    
    
    
    
    
}

