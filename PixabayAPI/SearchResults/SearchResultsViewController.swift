//
//  SearchResultsViewController.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import UIKit

class SearchResultsViewController: UIViewController {
  
  let networkProvider: NetworkProvider
  var searchString = ""
  
  private let imagesTableView = UITableView()
  private var imageInfo: [ImageInfo] = [] {
    didSet {
      self.imagesTableView.reloadData()
    }
  }
  
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
    setupNavbar()
    setupViews()
    setupLayouts()
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
  
  private func getImageURL(row: Int) -> URL? {
    guard row <= imageInfo.count
    else {
      return URL(fileURLWithPath: "missingImageURL")
    }
    return imageInfo[row].largeImageURL
  }
  
  private func getImageId(row: Int) -> Int {
    guard row <= imageInfo.count
    else {
      // this means there was an error, something useful shoud happen here...
      return 1
    }
    return imageInfo[row].id
  }
  
  private func fetchImageData(query: String) {
    networkProvider.fetchImageData(query: query, amount: 25) { (result) in
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
  
  private func calculateCellHeight(indexPathRow: Int) -> CGFloat {
    let images = imageInfo
    let defaultSize = kUI.ImageSize.regular + kUI.Padding.defaultPadding
    let imageWidth = Double(images[indexPathRow].webformatWidth)
    let imageHeight = Double(images[indexPathRow].webformatHeight)
    let contentWidth = Double(UIScreen.main.bounds.width - (kUI.Padding.defaultPadding * 2))
    let cellHeight = (imageHeight / (imageWidth / contentWidth))
    return cellHeight > 0 ? CGFloat(cellHeight) : defaultSize
  }
  
  private func presentAlert(title: String, message: String) {
    let alerController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .destructive) { _ in }
    alerController.addAction(okAction)
    self.present(alerController, animated: true, completion: nil)
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
    
    if let url = getImageURL(row: indexPath.row) {
      networkProvider.fetchImage(url: url) { image in
        DispatchQueue.main.async {
          cell.searchImage.image = image
        }
      }
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return calculateCellHeight(indexPathRow: indexPath.row)
  }
}
