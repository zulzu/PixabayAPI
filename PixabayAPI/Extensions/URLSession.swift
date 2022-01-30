//
//  URLSession.swift
//  PixabayAPI
//
//  Created by Andras Pal on 30/01/2022.
//

import Foundation

extension URLSession: NetworkExecutor {
  
  func executeRequest(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    self.dataTask(with: url, completionHandler: completionHandler)
      .resume()
  }
}
