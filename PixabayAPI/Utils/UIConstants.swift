//
//  UIConstants.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import UIKit

/// UI element size constants
enum UI {
  
  enum ImageSize {
    static let large: CGFloat = 400
    static let regular: CGFloat = 250
    static let small: CGFloat = 125
    static let largeSquare: CGSize = CGSize(width: UI.ImageSize.large, height: UI.ImageSize.large)
    static let regularSquare: CGSize = CGSize(width: UI.ImageSize.regular, height: UI.ImageSize.regular)
    static let smallSquare: CGSize = CGSize(width: UI.ImageSize.small, height: UI.ImageSize.small)
  }
  
  enum Padding {
    static let defaultPadding: CGFloat = 20
    static let largePadding: CGFloat = 30
  }
  
  enum Size {
    static let regularFont: CGFloat = 24
    static let smallFont: CGFloat = 16
    static let cornerRadius: CGFloat = 10
    static let textFieldHeight: CGFloat = 60
    static let searchButtonHeight: CGFloat = 60
    static let pixaLogoHeight: CGFloat = 40
  }
}
