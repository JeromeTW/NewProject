// NSObjectExtension.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh on 2019/9/18.

import Foundation

extension NSObject {
  static var className: String {
    return String(describing: self)
  }

  var className: String {
    return String(describing: type(of: self))
  }
}
