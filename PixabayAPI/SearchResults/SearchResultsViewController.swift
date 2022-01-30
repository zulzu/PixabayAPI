//
//  SearchResultsViewController.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import UIKit

class SearchResultsViewController: UIViewController {
  
  //------------------------------------
  // MARK: Properties
  //------------------------------------
  // # Private/Fileprivate
  private let imagesCollectionView: UICollectionView
  private let cache = NSCache<NSNumber, UIImage>()
  
  // # Public/Internal/Open
  lazy var viewModel = SearchResultsViewModel(
    imageInfoDidUpdate: { [weak self] in
      self?.imagesCollectionView.reloadData()
      self?.checkSearchResults()
    })
  var searchString = ""
  
  //=======================================
  // MARK: Public Methods
  //=======================================
  required init(collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())) {
    self.imagesCollectionView = collectionView
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchImageData(query: searchString)
    setupViews()
    setupCollectionLayout()
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setupNavbar()
  }
  
  //=======================================
  // MARK: Private Methods
  //=======================================
  private func setupViews() {
    view.backgroundColor = .bgColour
    imagesCollectionView.dataSource = self
    imagesCollectionView.delegate = self
    view.addSubview(imagesCollectionView)
    imagesCollectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: "searchCell")
    imagesCollectionView.bounces = false
    imagesCollectionView.backgroundColor = .bgColour
  }
  
  private func setupCollectionLayout() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    imagesCollectionView.collectionViewLayout = layout
  }
  
  private func setupConstraints() {
    imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      imagesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      imagesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -UI.Padding.defaultPadding),
      imagesCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      imagesCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
  }
  
  private func setupNavbar() {
    navigationItem.title = "Gallery"
  }
  
  private func updateNavbar() {
    navigationController?.setNavigationBarHidden(false, animated: true)
    let backButton = UIBarButtonItem()
    backButton.title = "Back"
    backButton.tintColor = .mainTextColour
    navigationItem.backBarButtonItem = backButton
    navigationItem.title = ""
  }
  
  private func checkSearchResults() {
    viewModel.imageInfo.isEmpty ? self.presentAlert(title: "No results", message: "Try to use different keywords") : nil
  }
}

extension SearchResultsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.imageInfo.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! ImageCollectionCell
    cell.backgroundColor = UIColor.bgColour
    //sets the value for the cached item
    let itemNumber = NSNumber(value: indexPath.item)
    //sets the image
    if let cachedImage = self.cache.object(forKey: itemNumber) {
      cell.searchImage.image = cachedImage
    } else {
      if let url = viewModel.getImageURL(row: indexPath.row, images: viewModel.imageInfo) {
        viewModel.imageLoader.fetchImage(url: url) { image in
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
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionCell
    guard let imageToPass = cell.searchImage.image else {
      return
    }
    let newSize = viewModel.calculateImageSize(image: imageToPass)
    let detailsVC = ImageDetailViewController(imageInfo: viewModel.imageInfo[indexPath.row],
                                              image: imageToPass.resizeImage(targetSize: newSize),
                                              viewHeight: newSize.height + 150)
    updateNavbar()
    navigationController?.pushViewController(detailsVC, animated: true)
  }
}
