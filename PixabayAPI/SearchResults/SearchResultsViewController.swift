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
  private var tempLabel = UILabel()
  
  private var imageInfo: [ImageInfo] = []
  
  required init(networkProvider: NetworkProvider = NetworkProvider()) {
    self.networkProvider = networkProvider
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = UIView()
    view.backgroundColor = .bgColour
    view.addSubview(tempLabel)
    tempLabel.text = searchString
    
    tempLabel.translatesAutoresizingMaskIntoConstraints = false
    tempLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
    tempLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    tempLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavbar()
    fetchImageData(query: searchString)
  }
  
  override func viewWillAppear(_ animated: Bool) {
  }
  
  private func setupNavbar() {
    navigationItem.title = "Gallery"
    navigationController?.navigationBar.prefersLargeTitles = false
  }
  
  private func fetchImageData(query: String) {
    networkProvider.fetchImageData(query: query, amount: 25) { (result) in
      switch result {
      case let .failure(error):
        print("error")
        print (error)
      case let .success(imageData):
        DispatchQueue.main.async {
          self.imageInfo = imageData
          if self.imageInfo.count == 0 {
            print("no results, try different keyword")
          }
          print("image data: \(self.imageInfo)")
        }
      }
    }
  }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let tempCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
    tempCell.backgroundColor = UIColor.bgColour
    return tempCell
  }
}
