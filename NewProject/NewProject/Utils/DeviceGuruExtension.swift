// DeviceGuruExtension.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh on 2019/9/18.

import DeviceGuru
import Foundation

extension DeviceGuru {
  var hasSensorHousing: Bool {
    let deviceName = hardware()
    let hasSensorHousingDevices: [Hardware] = [.iphoneX, .iphoneXS, .iphoneXSMax, .iphoneXSMaxChina, .iphoneXR]
    return hasSensorHousingDevices.contains(deviceName)
  }
}

extension CGFloat {
  static var statusAndNavigationTotalHeight: CGFloat {
    let navaigationHeight = CGFloat.navagationViewHeight
    var statusHeight: CGFloat = 0
    if DeviceGuru().hasSensorHousing {
      statusHeight = CGFloat.iPhoneXStatusBarHeight
    } else {
      statusHeight = CGFloat.defaultStatusBarHeight
    }
    return navaigationHeight + statusHeight
  }
}
