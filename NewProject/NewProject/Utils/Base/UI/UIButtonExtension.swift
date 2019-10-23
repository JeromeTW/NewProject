//
//  UIButtonExtension.swift
//  MoshiMember
//
//  Created by JEROME on 2019/10/18.
//  Copyright © 2019 jerome. All rights reserved.
//

import UIKit

extension UIButton {
  func underlineText(_ otherAttrs: [NSAttributedString.Key : Any]? = nil) {
    guard let title = title(for: .normal) else { return }

    let titleString = NSMutableAttributedString(string: title)
    var attrs = [NSAttributedString.Key : Any]()
    if let otherAttrs = otherAttrs {
      attrs = otherAttrs
    }
    attrs[.underlineStyle] = NSUnderlineStyle.single.rawValue
    titleString.addAttributes(attrs, range: NSRange(location: 0, length: title.count))
    setAttributedTitle(titleString, for: .normal)
  }
}
