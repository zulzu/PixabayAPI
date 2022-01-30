//
//  ImageLoaderService.swift
//  PixabayAPI
//
//  Created by Andras Pal on 30/01/2022.
//

import Foundation
import UIKit

class ImageLoaderService {
  
  private let requestExecutor: NetworkExecutor
  
  init(requestExecutor: NetworkExecutor = URLSession.shared) {
    self.requestExecutor = requestExecutor
  }
  
  // Fetch single image
  func fetchImage(url: URL, callback: @escaping (UIImage?) -> Void) {
    requestExecutor.executeRequest(with: url) { data, response, error in
      guard let data = data, error == nil else {
        callback(nil)
        return
      }
      callback(UIImage(data: data)!)
    }
  }
}
