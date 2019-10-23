//
//  ButtonWithImageAndLabelSuperView.swift
//  MoshiMember
//
//  Created by JEROME on 2019/10/22.
//  Copyright © 2019 jerome. All rights reserved.
//

import UIKit

@IBDesignable class ButtonWithImageAndLabelSuperView: UIView {
  
  weak var buttonWithImageAndLabelView: ButtonWithImageAndLabelView!
  var text: String? = nil {
    didSet {
      buttonWithImageAndLabelView.label.text = text
    }
  }

  var image: UIImage? = nil {
    didSet {
      buttonWithImageAndLabelView.imageView.image = image
    }
  }
  
  var imageAndLabelHeight: CGFloat = 55 {
    didSet {
      buttonWithImageAndLabelView.imageAndLabelHeight.constant = imageAndLabelHeight
    }
  }
  
  var font: UIFont = UIFont.systemFont(ofSize: 12) {
    didSet {
      buttonWithImageAndLabelView.label.font = font
    }
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    addXibView()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    addXibView()
  }
  
  func addXibView() {
    if let buttonWithImageAndLabelView = Bundle(for: ButtonWithImageAndLabelView.self).loadNibNamed(ButtonWithImageAndLabelView.className, owner: nil, options: nil)?.first as? ButtonWithImageAndLabelView {
      self.buttonWithImageAndLabelView = buttonWithImageAndLabelView
      addSubview(buttonWithImageAndLabelView)
      buttonWithImageAndLabelView.frame = bounds
    }
  }
  
}
