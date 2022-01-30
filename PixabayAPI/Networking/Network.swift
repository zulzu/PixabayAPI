//
//  Network.swift
//  PixabayAPI
//
//  Created by Andras Pal on 30/01/2022.
//

import Foundation
import UIKit

protocol Network {
  
  func createURL(query: String, amount: Int) -> URL?
  
  func fetchImageData(url: URL?, completion: @escaping (Result<[ImageInfo], NetworkError>) -> Void)
}
