//
//  NetworkExecutor.swift
//  PixabayAPI
//
//  Created by Andras Pal on 30/01/2022.
//

import Foundation

protocol NetworkExecutor {
  
  func executeRequest(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}
