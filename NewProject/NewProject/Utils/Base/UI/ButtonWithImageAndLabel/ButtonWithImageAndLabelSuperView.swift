// ButtonWithImageAndLabelSuperView.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh.

import UIKit

@IBDesignable class ButtonWithImageAndLabelSuperView: UIView {
  weak var buttonWithImageAndLabelView: ButtonWithImageAndLabelView!
  var text: String? {
    didSet {
      buttonWithImageAndLabelView.label.text = text
    }
  }

  var image: UIImage? {
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
