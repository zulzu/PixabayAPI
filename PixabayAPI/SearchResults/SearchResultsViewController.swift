//
//  SearchResultsViewController.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import UIKit

class SearchResultsViewController: UIViewController {
  
  var searchString = String()
  private var tempLabel = UILabel()
  
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
  }
  
  override func viewWillAppear(_ animated: Bool) {
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  private func setupNavbar() {
    navigationItem.title = "Gallery"
    navigationController?.navigationBar.prefersLargeTitles = false
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
