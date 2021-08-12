//
//  SearchView.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import UIKit

class SearchView: UIView {
  
  let bgView: UIView = {
    let bgView = UIView()
    bgView.backgroundColor = .black
    bgView.translatesAutoresizingMaskIntoConstraints = false
    return bgView
  }()
  
  let pixabayLogo: UIImageView = {
    let pixabayLogo = UIImageView(frame: .zero)
    pixabayLogo.image = UIImage(named: "pixabayLogo")
    pixabayLogo.translatesAutoresizingMaskIntoConstraints = false
    pixabayLogo.clipsToBounds = true
    pixabayLogo.contentMode = .scaleAspectFit
    return pixabayLogo
  }()
  
  let bgImage: UIImageView = {
    let bgImage = UIImageView(frame: .zero)
    bgImage.image = UIImage(named: "pixabayBackground")
    bgImage.translatesAutoresizingMaskIntoConstraints = false
    bgImage.contentMode = .scaleAspectFill
    return bgImage
  }()
  
  let title: UILabel = {
    let title = UILabel()
    title.font = UIFont.systemFont(ofSize: 20)
    title.text = "Stunning free images"
    title.textColor = .black
    title.numberOfLines = 0
    title.textAlignment = .left
    title.translatesAutoresizingMaskIntoConstraints = false
    return title
  }()
  
  let textView: TextFieldWithPadding = {
    let textView = TextFieldWithPadding()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.backgroundColor = .white
    textView.layer.cornerRadius = 10
    textView.font = UIFont.preferredFont(forTextStyle: .body)
    textView.textColor = .black
    textView.attributedPlaceholder = NSAttributedString(string: "Search images",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    textView.layer.borderColor = UIColor.blue.cgColor
    textView.layer.borderWidth = 1
    textView.textAlignment = NSTextAlignment.justified
    return textView
  }()
  
  let searchButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .black
    button.layer.cornerRadius = 8
    button.setTitle("Search now", for: UIControl.State.normal)
    button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    return button
  }()
  
  var searchTappedHandler: ((SearchView)->Void)?
  
  private func setupView() {
    
    backgroundColor = .black
    
    addSubview(bgView)
    bgView.insertSubview(bgImage, at: 0)
    addSubview(pixabayLogo)
    addSubview(title)
    addSubview(textView)
    addSubview(searchButton)
    
    NSLayoutConstraint.activate([
      bgView.topAnchor.constraint(equalTo: self.topAnchor),
      bgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      bgView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      bgImage.topAnchor.constraint(equalTo: bgView.topAnchor),
      bgImage.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
      bgImage.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
      bgView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      pixabayLogo.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 60),
      pixabayLogo.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      pixabayLogo.heightAnchor.constraint(equalToConstant: 40),
      pixabayLogo.widthAnchor.constraint(equalToConstant: calculateLogoWidth())
    ])
    
    NSLayoutConstraint.activate([
      title.topAnchor.constraint(equalTo: pixabayLogo.bottomAnchor, constant: 40),
      title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
    ])
    
    NSLayoutConstraint.activate([
      
      textView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
      textView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      textView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
      textView.heightAnchor.constraint(equalToConstant: 60)
    ])
    
    NSLayoutConstraint.activate([
      
      searchButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
      searchButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      searchButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
      searchButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
  
  @objc func buttonAction(_ sender:UIButton!)
  {
    self.searchTappedHandler?(self)
  }
  
  private func calculateLogoWidth() -> CGFloat {
    guard let imageSize = pixabayLogo.image?.size else {
      return 150
    }
    let newHeight = imageSize.width / (imageSize.height / 40)
    return newHeight
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupView()
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
