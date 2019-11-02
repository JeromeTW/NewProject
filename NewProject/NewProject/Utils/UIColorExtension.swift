// UIColorExtension.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh.

import UIKit

extension UIColor {
  func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
    return UIGraphicsImageRenderer(size: size).image { rendererContext in
      self.setFill()
      rendererContext.fill(CGRect(origin: .zero, size: size))
    }
  }
}
