//
//  PhotographerViewModel.swift
//  PixabayAPI
//
//  Created by Andras Pal on 23/08/2021.
//

import UIKit

class PhotographerViewModel {
  
  let networkProvider = NetworkProvider()
  var searchString = ""
  var imageInfo: [ImageInfo] = [] {
    didSet {
      self.imageInfoDidUpdate()
    }
  }
  let imageInfoDidUpdate: () -> ()
  
  init(imageInfoDidUpdate: @escaping ()->()) {
    self.imageInfoDidUpdate = imageInfoDidUpdate
  }
  
  func getImageURL(row: Int, images: [ImageInfo]) -> URL? {
    guard row <= images.count
    else {
      return URL(fileURLWithPath: "missingImageURL")
    }
    return images[row].largeImageURL
  }
  
  func fetchImageData(query: String) {
    networkProvider.fetchImageData(url: networkProvider.createURL(query: query, amount: 30)) { (result) in
      switch result {
      case let .failure(error):
        print (error)
      case let .success(imageData):
        DispatchQueue.main.async {
          self.imageInfo = imageData
        }
      }
    }
  }
  
  func calculateCellHeight(row: Int, images: [ImageInfo]) -> CGFloat {
    let defaultSize = kUI.ImageSize.regular + kUI.Padding.defaultPadding
    let imageWidth = Double(images[row].webformatWidth)
    let imageHeight = Double(images[row].webformatHeight)
    let contentWidth = Double(UIScreen.main.bounds.width - (kUI.Padding.defaultPadding * 2))
    let cellHeight = round( (imageHeight / (imageWidth / contentWidth)) * 100 ) / 100
    return cellHeight > 0 ? CGFloat(cellHeight) : defaultSize
  }
  
  func calculateImageSize(image: UIImage) -> CGSize {
    let originalWidth = image.size.width
    let originalHeight = image.size.height
    let newWidth = UIScreen.main.bounds.width * 1.2
    let newHeight = originalHeight/(originalWidth/newWidth)
    return CGSize(width: newWidth, height: newHeight)
  }
}
