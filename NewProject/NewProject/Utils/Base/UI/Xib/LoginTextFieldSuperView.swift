//
//  LoginTextFieldSuperView.swift
//  VCLifeCycle
//
//  Created by JEROME on 2019/10/17.
//  Copyright © 2019 jerome. All rights reserved.
//

import UIKit

@IBDesignable class LoginTextFieldSuperView: BaseView {
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    addXibView()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    addXibView()
  }
  
  func addXibView() {
    if let loginTextFIeldView = Bundle(for: LoginTextFieldView.self).loadNibNamed(LoginTextFieldView.className, owner: nil, options: nil)?.first as? UIView {
      addSubview(loginTextFIeldView)
      loginTextFIeldView.frame = bounds
    }
  }
  
}
