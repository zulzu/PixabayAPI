//
//  ImageDetail.swift
//  PixabayAPI
//
//  Created by Andras Pal on 15/08/2021.
//

import UIKit

class ImageDetailView: UIView {
  
  let scrollViewHeight: CGFloat
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.backgroundColor = .bgColour
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  private let scrollViewContainer: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.spacing = 10
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let bgView: UIView = {
    let bgView = UIView()
    bgView.backgroundColor = .bgColour
    bgView.translatesAutoresizingMaskIntoConstraints = false
    return bgView
  }()
  
  let bgImage: UIImageView = {
    let bgImage = UIImageView(frame: .zero)
    bgImage.clipsToBounds = true
    bgImage.translatesAutoresizingMaskIntoConstraints = false
    bgImage.contentMode = .scaleAspectFill
    return bgImage
  }()
  
  let userName: UILabel = {
    let title = UILabel()
    title.font = UIFont.boldSystemFont(ofSize: kUI.Size.regularFont)
    title.textColor = .mainTextColour
    title.numberOfLines = 2
    title.textAlignment = .left
    title.translatesAutoresizingMaskIntoConstraints = false
    return title
  }()
  
  let numberOfLikes: UILabel = {
    let title = UILabel()
    title.font = UIFont.systemFont(ofSize: kUI.Size.regularFont)
    title.textColor = .mainTextColour
    title.numberOfLines = 2
    title.textAlignment = .left
    title.translatesAutoresizingMaskIntoConstraints = false
    return title
  }()
  
  private func setupView() {
    backgroundColor = .bgColour
    addSubview(scrollView)
    scrollView.addSubview(scrollViewContainer)
    scrollViewContainer.addSubview(bgView)
    bgView.insertSubview(bgImage, at: 0)
    bgView.addSubview(userName)
    bgView.addSubview(numberOfLikes)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: self.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
    NSLayoutConstraint.activate([
      scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
      scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])
    NSLayoutConstraint.activate([
      bgView.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor),
      bgView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
      bgView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
      bgView.bottomAnchor.constraint(equalTo: scrollViewContainer.bottomAnchor),
      bgView.heightAnchor.constraint(equalToConstant: scrollViewHeight)
    ])
    NSLayoutConstraint.activate([
      bgImage.topAnchor.constraint(equalTo: bgView.topAnchor),
      bgImage.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
    ])
    NSLayoutConstraint.activate([
      userName.topAnchor.constraint(equalTo: bgImage.bottomAnchor, constant: kUI.Padding.defaultPadding),
      userName.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: kUI.Padding.defaultPadding),
      userName.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -kUI.Padding.defaultPadding),
    ])
    NSLayoutConstraint.activate([
      numberOfLikes.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: kUI.Padding.defaultPadding),
      numberOfLikes.leadingAnchor.constraint(equalTo: userName.leadingAnchor, constant: 0),
      numberOfLikes.trailingAnchor.constraint(equalTo: userName.trailingAnchor, constant: 0),
    ])
  }
  
  required init(scrollViewHeight: CGFloat) {
    self.scrollViewHeight = scrollViewHeight
    super.init(frame: .zero)
    setupView()
    setupConstraints()
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
