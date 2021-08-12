//
//  ImageInfo.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import Foundation

//TODO: might need to revisit these, probably wont use all of them. CodingKey for user_id?
struct ImageInfo: Decodable {
  
  let id: Int
  let previewURL: URL?
  let previewWidth: Int
  let previewHeight: Int
  let webformatURL: URL?
  let webformatWidth: Int
  let webformatHeight: Int
  let largeImageURL: URL?
  let likes: Int
  let user_id: Int
  let user: String
  let userImageURL: URL?
}
