//
//  WorkflowVC.swift
//  flowe
//
//  Created by Mehmet Yavuz Zenginerler on 12/1/21.
//

import UIKit

class WorkflowVC: UIViewController {
    
    @IBOutlet weak var theContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let childView = UIHostingController(rootView: WorkflowSwiftUIView())
        addChild(childView)
        childView.view.frame = theContainer.bounds
        theContainer.addSubview(childView.view)
        assignbackground()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        darkModeCheck()
    }
    
    func assignbackground() {
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
            (view.subviews[0] as! UIImageView).image = UIImage(named: "sharp_light")
        } else if (Variables.appTheme == 2) {
            overrideUserInterfaceStyle = .dark
            (view.subviews[0] as! UIImageView).image = UIImage(named: "sharp_dark")
        } else {
            print("\nTheme ERROR")
        }
    }
}
