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
    var minutes = 25
    var pomo: Pomodoro?
    var count = 0
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
        RemainTimeLabel.text = "25"
        statusLabel.text = "working"
        work = true
        minutes = 25
        timer.invalidate()
        statusLabel.backgroundColor = UIColor .red
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(HomeViewController.timerClass), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func breakButton(_ sender: Any) {
        RemainTimeLabel.text = "5"
        statusLabel.text = "relaxing"
        work = false
        minutes = 5
        timer.invalidate()
        statusLabel.backgroundColor = UIColor .green
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(HomeViewController.timerClass), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func resetButton(_ sender: Any) {
        count = 0
        numPomoLabel.text = "\(count)"
        
        
    }
    
    
    @objc func timerClass() {
        minutes -= 1
        RemainTimeLabel.text = String(minutes)
        if minutes == 0 {
            timer.invalidate()
            if work == true {
                statusLabel.backgroundColor = UIColor .green
                work = false
                count += 1
                print("count", count)
                numPomoLabel.text = "\(count)"
            }
            else {
                statusLabel.backgroundColor = UIColor .red
                work = true
            }
        }
    }
    
    
    
    
    
    
    
}

