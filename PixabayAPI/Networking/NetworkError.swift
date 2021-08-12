//
//  NetworkError.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import Foundation

enum NetworkError: Error {
  
  case missingUrl, apiError(Error), invalidResponse, other(Error)
  
  var locolizedDescription: String {
    switch self {
    case .missingUrl:
      return "Wrong URL"
    case let .apiError(error):
      return error.localizedDescription
    case .invalidResponse:
      return "No successful response from server"
    case let .other(error):
      return error.localizedDescription
    }
  }
}
