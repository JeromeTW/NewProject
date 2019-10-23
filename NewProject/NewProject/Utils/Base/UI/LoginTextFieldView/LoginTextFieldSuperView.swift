//
//  LoginTextFieldSuperView.swift
//  VCLifeCycle
//
//  Created by JEROME on 2019/10/17.
//  Copyright © 2019 jerome. All rights reserved.
//

import UIKit

@IBDesignable class LoginTextFieldSuperView: UIView {
  
  weak var loginTextFieldView: LoginTextFieldView!
  var title = "" {
    didSet {
      loginTextFieldView.label.text = title
    }
  }
  
  var placeHolder: String? = nil {
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
