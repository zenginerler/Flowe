//
//  WorkflowVC.swift
//  flowe
//
//  Created by Mehmet Yavuz Zenginerler on 12/1/21.
//

import UIKit

class WorkflowVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        darkModeCheck()
    }
    
    func assignbackground() {
          let background = UIImage(named: "bg_wave")

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
        } else if (Variables.appTheme == 2) {
            overrideUserInterfaceStyle = .dark
        } else {
            print("\nTheme ERROR")
        }
    }
}
