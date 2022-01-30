//
//  SearchResultsViewModel.swift
//  PixabayAPI
//
//  Created by Andras Pal on 15/08/2021.
//

import UIKit

class SearchResultsViewModel {
  
  //------------------------------------
  // MARK: Properties
  //------------------------------------
  // # Private/Fileprivate
  private let networkProvider: Network
  
  // # Public/Internal/Open
  let imageLoader: ImageLoaderService
  var imageInfo: [ImageInfo] = [] {
    didSet {
      self.imageInfoDidUpdate()
    }
  }
  let imageInfoDidUpdate: () -> ()
  
  //=======================================
  // MARK: Public Methods
  //=======================================
  init(networkProvider: Network = NetworkProvider(),
       imageLoading: ImageLoaderService = ImageLoaderService(),
       imageInfoDidUpdate: @escaping ()->()) {
    self.networkProvider = networkProvider
    self.imageLoader = imageLoading
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
    networkProvider.fetchImageData(url: networkProvider.createURL(query: query, amount: 60)) { (result) in
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
  
  func calculateImageSize(image: UIImage) -> CGSize {
    let originalWidth = image.size.width
    let originalHeight = image.size.height
    let newWidth = UIScreen.main.bounds.width * 1.2
    let newHeight = originalHeight/(originalWidth/newWidth)
    return CGSize(width: newWidth, height: newHeight)
  }
}
