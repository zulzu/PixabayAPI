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
  
  let photographerButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .textFieldBG
    button.contentHorizontalAlignment = .leading
    button.titleLabel?.font = UIFont.systemFont(ofSize: UI.Size.smallFont)
    button.titleLabel?.textColor = .mainTextColour
    button.setImage(UIImage(named: "chevronRight"), for: .normal)
    button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 5)
    button.imageEdgeInsets = UIEdgeInsets(top: 5, left: UIScreen.main.bounds.width - (UI.Padding.defaultPadding * 2), bottom: 5, right: 5)
    button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    return button
  }()
  
  private let divider: UIView = {
    let divider = UIView()
    divider.backgroundColor = .white
    divider.translatesAutoresizingMaskIntoConstraints = false
    return divider
  }()
  
  let numberOfLikes: UILabel = {
    let title = UILabel()
    title.font = UIFont.systemFont(ofSize: UI.Size.smallFont)
    title.textColor = .mainTextColour
    title.numberOfLines = 2
    title.textAlignment = .left
    title.translatesAutoresizingMaskIntoConstraints = false
    return title
  }()
  
  var photographerTappedHandler: ((ImageDetailView)->Void)?
  @objc func buttonAction(_ sender:UIButton!)
  {
    self.photographerTappedHandler?(self)
  }
  private func setupView() {
    backgroundColor = .bgColour
    addSubview(scrollView)
    scrollView.addSubview(scrollViewContainer)
    scrollViewContainer.addSubview(bgView)
    bgView.insertSubview(bgImage, at: 0)
    addSubview(photographerButton)
    photographerButton.addSubview(divider)
    divider.alpha = 0.4
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
      photographerButton.topAnchor.constraint(equalTo: bgImage.bottomAnchor, constant: UI.Padding.defaultPadding),
      photographerButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 0),
      photographerButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: 0),
      photographerButton.heightAnchor.constraint(equalToConstant: 40)
    ])
    
    NSLayoutConstraint.activate([
      divider.topAnchor.constraint(equalTo: photographerButton.bottomAnchor, constant: 0),
      divider.leadingAnchor.constraint(equalTo: photographerButton.leadingAnchor, constant: 0),
      divider.trailingAnchor.constraint(equalTo: photographerButton.trailingAnchor, constant: 0),
      divider.heightAnchor.constraint(equalToConstant: 1)
    ])
    
    NSLayoutConstraint.activate([
      numberOfLikes.topAnchor.constraint(equalTo: photographerButton.bottomAnchor, constant: UI.Padding.defaultPadding),
      numberOfLikes.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: UI.Padding.defaultPadding),
      numberOfLikes.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -UI.Padding.defaultPadding)
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
