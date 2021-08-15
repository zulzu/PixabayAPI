//
//  ImageDetailViewController.swift
//  PixabayAPI
//
//  Created by Andras Pal on 15/08/2021.
//

import UIKit

class ImageDetailViewController: UIViewController {
  
  let networkProvider: NetworkProvider
  let imageInfo: ImageInfo
  let image: UIImage
  let viewHeight: CGFloat
  lazy var imageDetailView: ImageDetailView = {
    let detailsView = ImageDetailView(scrollViewHeight: viewHeight)
    return detailsView
  }()
  
  init(networkProvider: NetworkProvider = NetworkProvider(),
       imageInfo: ImageInfo,
       image: UIImage,
       viewHeight: CGFloat) {
    self.networkProvider = networkProvider
    self.imageInfo = imageInfo
    self.image = image
    self.viewHeight = viewHeight
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    
    view = imageDetailView
    imageDetailView.bgImage.image = image
    imageDetailView.numberOfLikes.text = "Number of likes: \(imageInfo.likes)"
    imageDetailView.userName.text = "Photographer: " + imageInfo.user
  }
}
