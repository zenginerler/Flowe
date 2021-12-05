//
//  HomeViewController.swift
//  flowe
//
//  Created by Yixing Ma on 11/8/21.
//

import UIKit
import CoreData
import EventKit
import Lottie
import AVFoundation

class Pomodoro {
    var num = 0
}

class HomeViewController: UIViewController {
    var timer = Timer()
    var minutes = 25
    var pomo: Pomodoro?
    var count = 0
    var work: Bool = true
    
    // pomodoro stacks
    @IBOutlet weak var remainingTimeStack: UIStackView!
    @IBOutlet weak var pomodoroCounter: UIStackView!
    @IBOutlet weak var pomodoroStackView: UIStackView!
    
    // Home Btttons
    @IBOutlet weak var button_TL: UIButton!
    @IBOutlet weak var button_TR: UIButton!
    @IBOutlet weak var button_BL: UIButton!
    @IBOutlet weak var button_BR: UIButton!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var resetPomo: UIButton!
    @IBOutlet weak var breakB: UIButton!
    @IBOutlet weak var startB: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var RemainTimeLabel: UILabel!
    @IBOutlet weak var numPomoLabel: UILabel!
    @IBOutlet weak var timerState: UILabel!
    
    var takingABreak = false
    
    var audioPlayer: AVAudioPlayer?
    
    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    
    var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        customizeButtons()
        getFirstName()
        playSound(file: Variables.sound)
        
        // Starting center value
        self.nameLabel.center.x = self.view.center.x + self.view.bounds.width
        
        // name animation
        UIView.animate(
            withDuration: 1.0,
            animations: {
                self.nameLabel.center.x -= self.view.bounds.width
            }
        )
        
        //comment below line to bring stack view back
        pomodoroStackView.isHidden = true
        remainingTimeStack.isHidden = true
        pomodoroCounter.isHidden = true
        
        // cosmetic instatiation
        nameLabel.text = "Welcome, \(Variables.firstName)!"
        RemainTimeLabel.layer.masksToBounds = true
        RemainTimeLabel.layer.cornerRadius = 8
        wrapperView.layer.cornerRadius = 8
        nameLabel.layer.opacity = 30
        wrapperView.layer.opacity = 30
        resetPomo.layer.cornerRadius = 8
        breakB.layer.cornerRadius = 8
        startB.layer.cornerRadius = 8
        timerState.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        darkModeCheck()
        getFirstName()
        nameLabel.text = "Welcome, \(Variables.firstName)!"
        animationView?.play()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.animationView?.play()
        }
    }
    
    @IBAction func calendarButtonPress(_ sender: Any) {
        guard let url = URL(string: "calshow://") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func startButton(_ sender: Any) {
        timerState.text = "Working..."
        timerState.isHidden = false
        playSound(file: "tick")
        animationView?.stop()
        animationView?.removeFromSuperview()
        startTimerAnimation(animation: "timer")
        RemainTimeLabel.text = "25 mins"
        RemainTimeLabel.backgroundColor = UIColor.init(named: "custom_green")
        statusLabel.text = "working"
        work = true
        minutes = 25
        timer.invalidate()
        statusLabel.backgroundColor = UIColor.red
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(HomeViewController.timerClass), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func breakButton(_ sender: Any) {
        timerState.text = "Taking a break..."
        timerState.isHidden = false
        takingABreak = true
        
        //start the break animation and play sound
        playSound(file: "slow")
        animationView?.stop()
        animationView?.removeFromSuperview()
        startTimerAnimation(animation: "pause")
        
        // timer code for break
        RemainTimeLabel.text = "5 mins"
        RemainTimeLabel.backgroundColor = UIColor.init(named: "custom_red")
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
        minutes -= 25
        RemainTimeLabel.text = "\(String(minutes)) mins"
        if minutes < 1 {
            playSound(file: "drum")
            
            // alert if taking a break
            if takingABreak {
                timeIsUp(title: "Break Time Over", message: "It's great to take breaks! Now it's time to be productive.", button: "Back to Work")
                takingABreak = false
                timerState.text = "Resume timer"
                RemainTimeLabel.backgroundColor = UIColor.init(named: "custom_red")
            }
            else{
                timeIsUp(title: "Time is Up", message: "Great Job! You were productive for 25 minutes!", button: "Confirm")
                timerState.text = "Pomodoro Acheived!"
                animationView?.stop()
                animationView?.removeFromSuperview()
                startTimerAnimation(animation: "checkmark")
            }
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
    
    func startTimerAnimation(animation: String) {
        //Lottie animation settings
        animationView = .init(name: animation)
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1
        animationView?.frame = wrapperView.bounds
        wrapperView.addSubview(animationView!)
        animationView?.play()
    }
    
    func timeIsUp(title: String, message: String, button: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let selectAction = UIAlertAction(title: button,
                                         style: .default,
                                         handler: nil)
        alert.addAction(selectAction)
        present(alert, animated: true)
    }
    
    func customizeButtons() {
//        self.button_TL.applyGradient(colours: [.yellow, .orange])
        self.button_TR.backgroundColor = UIColor.init(named: "custom_orange")
        self.button_BL.backgroundColor = UIColor.init(named: "custom_orange")
        
//        self.button_BR.applyGradient(colours: [.purple, .blue])

//        button_TL.layer.masksToBounds = true
        button_TR.layer.masksToBounds = true
        button_BL.layer.masksToBounds = true
//        button_BR.layer.masksToBounds = true
//        button_TL.layer.cornerRadius = 10
        button_TR.layer.cornerRadius = 10
        button_BL.layer.cornerRadius = 10
//        button_BR.layer.cornerRadius = 10
    }
    
    func getFirstName () {
        let singleUser = context.object(with: Variables.userID!)
        let profileNSObj = singleUser.value(forKey: "profile") as! NSManagedObject
        Variables.firstName = "\(profileNSObj.value(forKey: "firstName") as! String)"
    }
    
    func playSound(file: String){
        let pathToSound = Bundle.main.path(forResource: file, ofType: "mp3")!
        let url = URL(fileURLWithPath: pathToSound)
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer!.play()
        }
        catch{
            
        }
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
