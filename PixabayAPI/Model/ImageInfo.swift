//
//  ImageInfo.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import Foundation

struct ImageInfo: Decodable, Equatable {
  
  let webformatWidth: Int
  let webformatHeight: Int
  let largeImageURL: URL?
  let likes: Int
  let user: String
}
