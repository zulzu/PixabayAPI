//
//  PixabaySearchNavigationController.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import UIKit

class PixabaySearchNavigationController: UINavigationController {
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    navigationBar.barStyle = .black
    navigationBar.isTranslucent = false
    navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainTextColour]
  }
}
