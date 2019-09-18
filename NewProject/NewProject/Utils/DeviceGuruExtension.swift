//
//  DeviceGuruExtension.swift
//  JeromeYoutube
//
//  Created by JEROME on 2019/9/17.
//  Copyright © 2019 jerome. All rights reserved.
//

import Foundation
import  DeviceGuru

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
