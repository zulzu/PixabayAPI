//
//  SearchResultsViewController.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import UIKit

class SearchResultsViewController: UIViewController {
  
  var searchString = ""
  private let networkProvider: NetworkProvider
  private let imagesTableView = UITableView()
  private var imageInfo: [ImageInfo] = [] {
    didSet {
      self.imagesTableView.reloadData()
    }
  }
  private let cache = NSCache<NSNumber, UIImage>()
  
  required init(networkProvider: NetworkProvider = NetworkProvider()) {
    self.networkProvider = networkProvider
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchImageData(query: searchString)
    setupViews()
    setupLayouts()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setupNavbar()
  }
  
  private func setupViews() {
    view.backgroundColor = .bgColour
    imagesTableView.dataSource = self
    imagesTableView.delegate = self
    view.addSubview(imagesTableView)
    imagesTableView.register(ImageCell.self, forCellReuseIdentifier: "searchCell")
    imagesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    imagesTableView.bounces = false
  }
  
  private func setupLayouts() {
    imagesTableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imagesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      imagesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -kUI.Padding.defaultPadding),
      imagesTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      imagesTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
  }
  
  private func setupNavbar() {
    navigationItem.title = "Gallery"
  }
  
  func getImageURL(row: Int, images: [ImageInfo]) -> URL? {
    guard row <= images.count
    else {
      return URL(fileURLWithPath: "missingImageURL")
    }
    return images[row].largeImageURL
  }
  
  func calculateCellHeight(row: Int, images: [ImageInfo]) -> CGFloat {
    let defaultSize = kUI.ImageSize.regular + kUI.Padding.defaultPadding
    let imageWidth = Double(images[row].webformatWidth)
    let imageHeight = Double(images[row].webformatHeight)
    let contentWidth = Double(UIScreen.main.bounds.width - (kUI.Padding.defaultPadding * 2))
    let cellHeight = round( (imageHeight / (imageWidth / contentWidth)) * 100 ) / 100
    return cellHeight > 0 ? CGFloat(cellHeight) : defaultSize
  }
  
  private func fetchImageData(query: String) {
    networkProvider.fetchImageData(url: networkProvider.createURL(query: query, amount: 25)) { (result) in
      switch result {
      case let .failure(error):
        self.presentAlert(title: "Error", message: "Detailed error messages are not implemented")
        print (error)
      case let .success(imageData):
        DispatchQueue.main.async {
          self.imageInfo = imageData
          if self.imageInfo.count == 0 {
            self.presentAlert(title: "No results", message: "Try to use different keywords")
          }
        }
      }
    }
  }
  
  private func updateNavbar() {
    navigationController?.setNavigationBarHidden(false, animated: true)
    let backButton = UIBarButtonItem()
    backButton.title = "Back"
    backButton.tintColor = .mainTextColour
    navigationItem.backBarButtonItem = backButton
    navigationItem.title = ""
  }
  
  private func calculateImageSize(image: UIImage) -> CGSize {
    let originalWidth = image.size.width
    let originalHeight = image.size.height
    let newWidth = UIScreen.main.bounds.width * 1.2
    let newHeight = originalHeight/(originalWidth/newWidth)
    return CGSize(width: newWidth, height: newHeight)
  }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return imageInfo.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! ImageCell
    cell.backgroundColor = UIColor.bgColour
    cell.selectionStyle = .none
    //sets the value for the cached item
    let itemNumber = NSNumber(value: indexPath.item)
    //sets the image
    if let cachedImage = self.cache.object(forKey: itemNumber) {
      cell.searchImage.image = cachedImage
    } else {
      if let url = getImageURL(row: indexPath.row, images: imageInfo) {
        networkProvider.fetchImage(url: url) { image in
          DispatchQueue.main.async {
            guard let downloadedImage = image else {
              return cell.searchImage.image = UIImage(named: "missingImage")
            }
            cell.searchImage.image = downloadedImage
            self.cache.setObject(downloadedImage, forKey: itemNumber)
          }
        }
      }
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return calculateCellHeight(row: indexPath.row, images: imageInfo)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! ImageCell
    guard let imageToPass = cell.searchImage.image else {
      return
    }
    let newSize = calculateImageSize(image: imageToPass)
    let detailsVC = ImageDetailViewController(imageInfo: imageInfo[indexPath.row],
                                              image: imageToPass.resizeImage(targetSize: newSize),
                                              viewHeight: newSize.height + 150)
    updateNavbar()
    navigationController?.pushViewController(detailsVC, animated: true)
  }
}
