//
//  SegueSwiftUI.swift
//  flowe
//
//  Created by Mehmet Yavuz Zenginerler on 11/4/21.
//

import SwiftUI
import UIKit

struct SegueSwiftUI: UIViewControllerRepresentable {
    let storyboard: String
    let VC: String

  func makeUIViewController(context: UIViewControllerRepresentableContext<SegueSwiftUI>) -> SegueVC {
    //Load the storyboard
    let loadedStoryboard = UIStoryboard(name: storyboard, bundle: nil)
    
    //Load the ViewController
     return loadedStoryboard.instantiateViewController(withIdentifier: VC) as! SegueVC
  }
  
  func updateUIViewController(_ uiViewController: SegueVC, context: UIViewControllerRepresentableContext<SegueSwiftUI>) {
  }
}
