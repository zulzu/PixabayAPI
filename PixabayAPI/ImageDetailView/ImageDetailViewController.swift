//
//  ImageDetailViewController.swift
//  PixabayAPI
//
//  Created by Andras Pal on 15/08/2021.
//

import UIKit

class ImageDetailViewController: UIViewController {
  
  let imageInfo: ImageInfo
  let image: UIImage
  let viewHeight: CGFloat
  lazy var imageDetailView: ImageDetailView = {
    let detailsView = ImageDetailView(scrollViewHeight: viewHeight)
    return detailsView
  }()
  
  init(imageInfo: ImageInfo,
       image: UIImage,
       viewHeight: CGFloat) {
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
    imageDetailView.photographerTappedHandler = handlePhotographerButtonTap(_:)
    imageDetailView.bgImage.image = image
    imageDetailView.photographerButton.setTitle("Photographer: \(imageInfo.user)", for: .normal)
    imageDetailView.numberOfLikes.text = "Number of likes: \(imageInfo.likes)"
  }
  
  private func handlePhotographerButtonTap(_ customView: ImageDetailView) {
    let photographerVC = PhotographerViewController()
    photographerVC.photographer = imageInfo.user
    updateNavbar()
    self.navigationController?.pushViewController(photographerVC, animated: true)
  }
  
  private func updateNavbar() {
    navigationController?.setNavigationBarHidden(false, animated: true)
    let backButton = UIBarButtonItem()
    backButton.title = "Back"
    backButton.tintColor = .mainTextColour
    navigationItem.backBarButtonItem = backButton
    navigationItem.title = ""
  }
}
