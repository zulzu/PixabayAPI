//
//  ViewController.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import UIKit

class SearchViewController: UIViewController {
  
  private let searchView = SearchView()
  
  override func loadView() {
    view = searchView
    searchView.searchTappedHandler = handleSearchButtonTap(_:)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  private func handleSearchButtonTap(_ customView: SearchView) {
    guard let searchString = searchView.textView.text else {
      print("error with the searchString")
      return
    }
    if searchString != "" {
      print("search string: \(searchString)")
    }
  }
}

