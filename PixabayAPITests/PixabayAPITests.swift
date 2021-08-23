//
//  PixabayAPITests.swift
//  PixabayAPITests
//
//  Created by Andras Pal on 16/08/2021.
//

import XCTest
@testable import PixabayAPI

class SearchResultsViewControllerTests: XCTestCase {
  
  let viewModel = PhotographerViewController()
  let images = [ImageInfo(id: 5,
                          previewURL: URL(string: "https://imgur.com/rickroll_small.jpg")!,
                          previewWidth: 500,
                          previewHeight: 200,
                          webformatURL: URL(string: "https://imgur.com/rickroll_small.jpg")!,
                          webformatWidth: 500,
                          webformatHeight: 200,
                          largeImageURL: URL(string: "https://imgur.com/rickroll_small.jpg")!,
                          likes: 11,
                          user_id: 22,
                          user: "anonymus"),
                ImageInfo(id: 10,
                          previewURL: URL(string: "https://imgur.com/rickroll_large.jpg")!,
                          previewWidth: 800,
                          previewHeight: 800,
                          webformatURL: URL(string: "https://imgur.com/rickroll_large.jpg")!,
                          webformatWidth: 800,
                          webformatHeight: 800,
                          largeImageURL: URL(string: "https://imgur.com/rickroll_large.jpg")!,
                          likes: 4,
                          user_id: 56,
                          user: "anonymus"),
                ImageInfo(id: 15,
                          previewURL: URL(string: "https://imgur.com/rickroll_mega.jpg")!,
                          previewWidth: 200,
                          previewHeight: 600,
                          webformatURL: URL(string: "https://imgur.com/rickroll_mega.jpg")!,
                          webformatWidth: 200,
                          webformatHeight: 600,
                          largeImageURL: URL(string: "https://imgur.com/rickroll_mega.jpg")!,
                          likes: 319,
                          user_id: 9871,
                          user: "anonymus")]
  
  func testImages() {
    let numberOfImages = 3
    
    XCTAssertTrue(numberOfImages == images.count)
  }
  
  func testGetImageURL() {
    let testURL1 = viewModel.viewModel.getImageURL(row: 0, images: images)
    let testURL2 = viewModel.viewModel.getImageURL(row: 1, images: images)
    let testURL3 = viewModel.viewModel.getImageURL(row: 2, images: images)
    
    XCTAssertTrue(((testURL1?.isFileURL) != nil))
    
    XCTAssertEqual(testURL1, URL(string: "https://imgur.com/rickroll_small.jpg"))
    XCTAssertEqual(testURL2, URL(string: "https://imgur.com/rickroll_large.jpg"))
    XCTAssertEqual(testURL3, URL(string: "https://imgur.com/rickroll_mega.jpg"))
    
    XCTAssertFalse(testURL1 == URL(string: "https://imgur.com/rickroll_large.jpg"))
  }
  
  // simple calculation: cellHeight = (imageHeight / (imageWidth / contentWidth))
  // test run on an iPhone12ProMax where the content width is 388
  func testCalculateCellHeight() {
    let cellHeight1 = viewModel.viewModel.calculateCellHeight(row: 0, images: images)
    let cellHeight2 = viewModel.viewModel.calculateCellHeight(row: 1, images: images)
    let cellHeight3 = viewModel.viewModel.calculateCellHeight(row: 2, images: images)
    
    XCTAssertEqual(cellHeight1, 155.2)
    XCTAssertEqual(cellHeight2, 388.0)
    XCTAssertEqual(cellHeight3, 1164.0)
  }
}
