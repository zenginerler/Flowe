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
    var work: Bool = true
    
    // Home Btttons
    @IBOutlet weak var button_TL: UIButton!
    @IBOutlet weak var button_TR: UIButton!
    @IBOutlet weak var button_BL: UIButton!
    @IBOutlet weak var button_BR: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var RemainTimeLabel: UILabel!
    @IBOutlet weak var numPomoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        customizeButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        darkModeCheck()
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
    
    func assignBackground() {
          let background = UIImage()

          var imageView : UIImageView!
          imageView = UIImageView(frame: view.bounds)
          imageView.contentMode =  UIView.ContentMode.scaleAspectFill
          imageView.clipsToBounds = true
          imageView.image = background
          imageView.center = view.center
          view.addSubview(imageView)
          self.view.sendSubviewToBack(imageView)
      }
    
    func darkModeCheck() {
        // Update the the theme according to user settings
        if (Variables.appTheme == 1) {
            overrideUserInterfaceStyle = .light
            (view.subviews[0] as! UIImageView).image = UIImage(named: "bg_1_light")
        } else if (Variables.appTheme == 2) {
            overrideUserInterfaceStyle = .dark
            (view.subviews[0] as! UIImageView).image = UIImage(named: "bg_1_dark")
        } else {
            print("\nTheme ERROR")
        }
    }
    
    func customizeButtons() {
        self.button_TL.applyGradient(colours: [.yellow, .orange])
        self.button_TR.applyGradient(colours: [.orange, .red])
        self.button_BL.applyGradient(colours: [.systemPink, .purple])
        self.button_BR.applyGradient(colours: [.purple, .blue])

        button_TL.layer.masksToBounds = true
        button_TR.layer.masksToBounds = true
        button_BL.layer.masksToBounds = true
        button_BR.layer.masksToBounds = true
        button_TL.layer.cornerRadius = 10
        button_TR.layer.cornerRadius = 10
        button_BL.layer.cornerRadius = 10
        button_BR.layer.cornerRadius = 10
    }
    
    
}

extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}
