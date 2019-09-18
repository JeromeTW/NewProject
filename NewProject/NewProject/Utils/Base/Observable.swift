// Observable.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh on 2019/9/18.

import Foundation

class Observable<T> {
  var value: T {
    didSet {
      DispatchQueue.main.async {
        self.valueChanged?(self.value)
      }
    }
  }

  private var valueChanged: ((T) -> Void)?

  init(value: T) {
    self.value = value
  }

  func addObserver(willPerfromImmediately: Bool = true, _ onChange: ((T) -> Void)?) {
    valueChanged = onChange
    if willPerfromImmediately {
      onChange?(value)
    }
  }

  func removeObserver() {
    valueChanged = nil
  }
}
