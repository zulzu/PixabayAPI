//
//  ImageCell.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {
  
  private let bgView: UIView = {
    let bgView = UIView()
    bgView.backgroundColor = .bgColour
    bgView.translatesAutoresizingMaskIntoConstraints = false
    return bgView
  }()
  
  let searchImage: UIImageView = {
    let image = UIImageView(frame: .zero)
    image.clipsToBounds = true
    image.contentMode = .scaleAspectFit
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  private func setupView() {
    
    contentView.clipsToBounds = true
    contentView.backgroundColor = .bgColour
    contentView.addSubview(bgView)
    bgView.addSubview(searchImage)
  }
  
  private func setupLayouts() {
    
    NSLayoutConstraint.activate([
      bgView.topAnchor.constraint(equalTo: self.topAnchor, constant: UI.Padding.defaultPadding),
      bgView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -UI.Padding.defaultPadding),
      bgView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: UI.Padding.defaultPadding),
      bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: UI.Padding.defaultPadding)
    ])
    
    NSLayoutConstraint.activate([
      searchImage.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
      searchImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: UI.Padding.defaultPadding),
      searchImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -UI.Padding.defaultPadding),
    ])
  }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupView()
    setupLayouts()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
