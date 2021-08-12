//
//  SearchResults.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import Foundation

struct SearchResults<Object: Decodable> : Decodable {
  
  var hits: [Object]
}
