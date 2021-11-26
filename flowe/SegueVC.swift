//
//  ViewController.swift
//  flowe
//
//  Created by Mehmet Yavuz Zenginerler on 11/4/21.
//

import UIKit
//import SwiftUI

class SegueVC: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        @IBOutlet weak var theContainer: UIView!
//        // Necessary code to upload the swiftUI file (login.swift)
//        let childView = UIHostingController(rootView: LoginUI())
//        addChild(childView)
//        childView.view.frame = theContainer.bounds
//        theContainer.addSubview(childView.view)
        
        
        homeButton.layer.cornerRadius = 10
        print(identify.userID)
    }


}

