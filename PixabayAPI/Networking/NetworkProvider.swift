//
//  NetworkProvider.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import UIKit

class NetworkProvider: Network {
  
  private let apiKey = "13197033-03eec42c293d2323112b4cca6"
  private let requestExecutor: NetworkExecutor
  
  init(requestExecutor: NetworkExecutor = URLSession.shared) {
    self.requestExecutor = requestExecutor
  }
  
  // Url creation, more info here: https://pixabay.com/api/docs/#api_search_images
  func createURL(query: String, amount: Int) -> URL? {
    var baseUrlComponents: URLComponents {
      var urlComponents = URLComponents(string: "https://pixabay.com/api")!
      urlComponents.queryItems = [URLQueryItem(name: "key", value: apiKey)]
      return urlComponents
    }
    var urlComps = baseUrlComponents
    urlComps.queryItems? += [
      URLQueryItem(name: "q", value: query),
      URLQueryItem(name: "per_page", value: "\(amount)"),
    ]
    let url = urlComps.url
    return url
  }
  
  //TODO: value must be between 3-200, limit it? | maybe more parameters later?
  func fetchImageData(
    url: URL?,
    completion: @escaping (Result<[ImageInfo], NetworkError>) -> Void
  ) {
    
    guard let url = url else {
      completion(.failure(.missingUrl))
      return
    }
    
    requestExecutor.executeRequest(
      with: url
    ) { [weak self] data, response, error in
      self?.handleResponse(data: data, response: response, error: error, completion: completion)
    }
  }
  
  // Extract completion handling
  func handleResponse(
    data: Data?,
    response: URLResponse?,
    error: Error?,
    completion: @escaping (Result<[ImageInfo], NetworkError>) -> Void
  ) {
    if let error = error {
      completion(.failure(.apiError(error)))
    }
    
    guard
      let data = data,
      let response = response as? HTTPURLResponse,
      200...299 ~= response.statusCode
    else {
      completion(.failure(.invalidResponse))
      return
    }
    do {
      let serverResponse = try JSONDecoder().decode(SearchResults<ImageInfo>.self, from: data)
      completion(.success(serverResponse.hits))
    }
    catch let unsuccessfulQuery {
      completion(.failure(.other(unsuccessfulQuery)))
    }
  }
}
