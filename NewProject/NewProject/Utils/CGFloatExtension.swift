// CGFloatExtension.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh on 2019/9/18.

import UIKit

extension CGFloat {
  // default
  static let defaultStatusBarHeight: CGFloat = 20.0
  static let iPhoneXStatusBarHeight: CGFloat = 44.0
  static let defaultNavigationBarHeight: CGFloat = .defaultStatusBarHeight + 44.0
  static let iPhoneXNavigationBarHeight: CGFloat = .iPhoneXStatusBarHeight + 44.0
  static let defaultTabBarHeight: CGFloat = 49.0
  static let iPhoneXTabBarHeight: CGFloat = .defaultTabBarHeight + 34.0
  static let defaultToolBarHeight: CGFloat = 44.0
  static let iPhoneXToolBarHeight: CGFloat = .defaultToolBarHeight + 39.0
  static let defaultKeyboardHeight: CGFloat = 216.0
  static let iPhoneXKeyboardHeight: CGFloat = .defaultKeyboardHeight + 75.0
  // customize
  static let zero: CGFloat = 0.0
  static let defaultMargin: CGFloat = 8.0
  static let defaultViewHeight: CGFloat = 44.0
  static let defaultCellRowHeight: CGFloat = 44.0
  static let defaultButtonHeight: CGFloat = 44.0
  static let defaultCornerRadius: CGFloat = 10.0

  var negativeValue: CGFloat {
    return (-1.0 * self)
  }

  static var navagationViewHeight: CGFloat {
    if UIApplication.shared.statusBarOrientation.isPortrait {
      return 44
    } else {
      return 32
    }
  }
}
