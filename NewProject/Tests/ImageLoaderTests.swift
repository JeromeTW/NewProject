// ImageLoaderTests.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh.

import XCTest

class ImageLoaderTests: XCTestCase {
  override class func setUp() {
    // This is the setUp() class method.
    // It is called before the first test method begins.
    // Set up any overall initial state here.
    logger.configure([.fault, .error, .debug, .info], shouldShow: false, shouldCache: true)
  }

  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_ImageLoader_imageByURL_when_URLExistBefore_doesNotAskQueueShootTwice() { // SypQueue
    let exp = expectation(description: "Download the image")
    let spyQueue = SypQueue()
    let imageLoader = ImageLoader.shared

    let successfulURL = URL(string: "https://i.ytimg.com/vi/z_xrgqTnM5E/hqdefault.jpg?sqp=-oaymwEiCKgBEF5IWvKriqkDFQgBFQAAAAAYASUAAMhCPQCAokN4AQ==&rs=AOn4CLBTL27i7gGtKmOqugtYG1hhdl8k-Q")!
    imageLoader.queue = spyQueue
    imageLoader.imageByURL(successfulURL) { image, _ in
      if image != nil {
        logger.log("testImageLoader-1")
        exp.fulfill()
      }
    }
    wait(for: [exp], timeout: 5)
  }

  func test_ImageLoader_imageByURL_with_wrongURL() {
    let exp = expectation(description: "Wrong URL")
    let imageLoader = ImageLoader.shared

    let wrongURL = URL(string: "https://asdasdasdada")!

    imageLoader.imageByURL(wrongURL) { image, _ in
      XCTAssert(image == nil)
      exp.fulfill()
    }
    wait(for: [exp], timeout: 5)
  }

  func testPerformanceExample() {
    // This is an example of a performance test case.
    measure {
      // Put the code you want to measure the time of here.
    }
  }
}
