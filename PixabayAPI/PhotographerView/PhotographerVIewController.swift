//
//  PhotographerViewController.swift
//  PixabayAPI
//
//  Created by Andras Pal on 23/08/2021.
//

import UIKit

class PhotographerViewController: UIViewController {
  
  var photographer = ""
  lazy var viewModel = PhotographerViewModel(
    imageInfoDidUpdate: { [weak self] in
      self?.imagesTableView.reloadData()
    })
  lazy var searchString = {
    "user:\(photographer)"
  }()
  private let imagesTableView: UITableView
  private let cache = NSCache<NSNumber, UIImage>()
  
  required init(tableView: UITableView = UITableView()) {
    self.imagesTableView = tableView
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchImageData(query: searchString)
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
    imagesTableView.register(ImageTableCell.self, forCellReuseIdentifier: "searchCell")
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
    navigationItem.title = "Photos from \(photographer)"
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

extension PhotographerViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.imageInfo.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! ImageTableCell
    cell.backgroundColor = UIColor.bgColour
    cell.selectionStyle = .none
    //sets the value for the cached item
    let itemNumber = NSNumber(value: indexPath.item)
    //sets the image
    if let cachedImage = self.cache.object(forKey: itemNumber) {
      cell.searchImage.image = cachedImage
    } else {
      if let url = viewModel.getImageURL(row: indexPath.row, images: viewModel.imageInfo) {
        viewModel.networkProvider.fetchImage(url: url) { image in
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
    return viewModel.calculateCellHeight(row: indexPath.row, images: viewModel.imageInfo)
  }
  
  //TODO: figure out how to show a single image without getting in a loop in the UI
  
  //  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  //    let cell = tableView.cellForRow(at: indexPath) as! ImageTableCell
  //    guard let imageToPass = cell.searchImage.image else {
  //      return
  //    }
  //    let newSize = viewModel.calculateImageSize(image: imageToPass)
  //    let detailsVC = ImageDetailViewController(imageInfo: viewModel.imageInfo[indexPath.row],
  //                                              image: imageToPass.resizeImage(targetSize: newSize),
  //                                              viewHeight: newSize.height + 150)
  //    updateNavbar()
  //    navigationController?.pushViewController(detailsVC, animated: true)
  //  }
}
