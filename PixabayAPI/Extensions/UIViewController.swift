//
//  UIViewController.swift
//  PixabayAPI
//
//  Created by Andras Pal on 15/08/2021.
//

import UIKit

extension UIViewController {
  
  func dismissKeyboard() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self,
                                                              action: #selector(UIViewController.dismissKeyboardTouchOutside))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc private func dismissKeyboardTouchOutside() {
    view.endEditing(true)
  }
  
  func presentAlert(title: String, message: String) {
    let alerController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .destructive) { _ in }
    alerController.addAction(okAction)
    self.present(alerController, animated: true, completion: nil)
  }
}
