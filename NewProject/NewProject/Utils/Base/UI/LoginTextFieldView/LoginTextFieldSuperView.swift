// LoginTextFieldSuperView.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh.

import UIKit

@IBDesignable class LoginTextFieldSuperView: UIView {
  weak var loginTextFieldView: LoginTextFieldView!
  var title = "" {
    didSet {
      loginTextFieldView.label.text = title
    }
  }

  var placeHolder: String? {
    didSet {
      loginTextFieldView.textField.placeholder = placeHolder
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
    if let loginTextFieldView = Bundle(for: LoginTextFieldView.self).loadNibNamed(LoginTextFieldView.className, owner: nil, options: nil)?.first as? LoginTextFieldView {
      self.loginTextFieldView = loginTextFieldView
      addSubview(loginTextFieldView)
      loginTextFieldView.frame = bounds
    }
  }
}
