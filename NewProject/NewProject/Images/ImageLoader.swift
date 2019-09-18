// ImageLoader.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh on 2019/9/18.

import UIKit

class ImageLoader {
  static let shared = ImageLoader()
  private let imageCache = NSCache<NSString, UIImage>()
  lazy var requestOperationDictionary = [URL: AsynchronousOperation]()

  lazy var queue: OperationQueue = {
    var queue = OperationQueue()
    queue.name = "ImageLoader"
    queue.maxConcurrentOperationCount = 4
    queue.qualityOfService = QualityOfService.userInitiated
    return queue
  }()

  func imageByURL(_ url: URL, completionHandler: @escaping (_ image: UIImage?, _ url: URL) -> Void) {
    // get image from cache
    if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) {
      completionHandler(imageFromCache, url)
      return
    } else {
      // if no image from cache, get image from url
      // 檢查是否有重複的下載圖片請求
      guard requestOperationDictionary[url] == nil else {
        let prevoiusOperation = requestOperationDictionary[url]!
        let blockOperation = BlockOperation {
          DispatchQueue.main.async {
            [weak self] in
            guard let self = self else {
              return
            }
            guard let image = self.imageCache.object(forKey: url.absoluteString as NSString) else {
              fatalError()
            }
            completionHandler(image, url)
          }
        }
        blockOperation.addDependency(prevoiusOperation)
        queue.addOperation(blockOperation)
        return
      }
      let request = APIRequest(url: url)
      func mainThreadCompletionHandler(image innerImage: UIImage?, _ url: URL) {
        DispatchQueue.main.async {
          completionHandler(innerImage, url)
        }
      }
      let operation = NetworkRequestOperation(request: request) { [weak self] result in
        guard let self = self else {
          assertionFailure()
          return
        }
        guard let operation = self.requestOperationDictionary[url] else {
          mainThreadCompletionHandler(image: nil, url)
          return
        }
        defer {
          self.requestOperationDictionary.removeValue(forKey: url)
          operation.completeOperation()
        }
        guard operation.isCancelled == false else {
          // 取消的話就不執行 CompletionHandler
          for dependenceOp in operation.dependencies {
            operation.removeDependency(dependenceOp)
          }
          return
        }

        switch result {
        case let .success(response):
          if let data = response.body {
            if let image = UIImage(data: data) {
              self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
              mainThreadCompletionHandler(image: image, url)
            } else {
              logger.log("Data Format Wrong")
              mainThreadCompletionHandler(image: nil, url)
            }
          } else {
            logger.log("No Data")
            mainThreadCompletionHandler(image: nil, url)
          }

        case .failure:
          logger.log("failed")
          mainThreadCompletionHandler(image: nil, url)
        }
      }
      requestOperationDictionary[url] = operation
      queue.addOperation(operation)
    }
  }

  func cancelRequest(url: URL) {
    // TODO: cell 不在畫面上時呼叫此函式。
    if let operation = requestOperationDictionary[url] {
      requestOperationDictionary.removeValue(forKey: url)
      operation.cancel()
      operation.completeOperation()
    }
  }
}
