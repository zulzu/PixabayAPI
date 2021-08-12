//
//  Colours.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import UIKit

// TODO: theme manager?
public extension UIColor {
  
  static let bgColour: UIColor = colour(name: "bgColour")
  static let mainTextColour: UIColor = colour(name: "mainTextColour")
  static let textFieldBG: UIColor = colour(name: "textFieldBG")
  static let textFieldTextColour: UIColor = colour(name: "textFieldTextColour")
  static let buttonColour: UIColor = colour(name: "buttonColour")
  
  private static func colour(name: String) -> UIColor {
    UIColor(named: name, in: Bundle.main, compatibleWith: nil)!
  }
}
