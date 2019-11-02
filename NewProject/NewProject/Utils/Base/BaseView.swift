//
//  BaseView.swift
//  Mod
//
//  Created by JEROME on 2019/9/23.
//  Copyright © 2019 jerome. All rights reserved.
//

import UIKit

class BaseView: UIView {

  required init?(coder: NSCoder) {
    logI("init?(coder: NSCoder)")
    super.init(coder: coder)
  }
  
  override init(frame: CGRect) {
    logI("init(frame: NSCoder)")
    super.init(frame: frame)
  }
  
  override func awakeFromNib() {
    logI("awakeFromNib")
    super.awakeFromNib()
  }
  
  override func willMove(toWindow newWindow: UIWindow?) {
    logI("willMove(toWindow newWindow: UIWindow?)")
    super.willMove(toWindow: newWindow)
  }
  
  override func didMoveToWindow() {
    logI("didMoveToWindow")
    super.didMoveToWindow()
  }
  
  override func willMove(toSuperview newSuperview: UIView?) {
    logI("willMove(toSuperview newSuperview: UIView?)")
    super.willMove(toSuperview: newSuperview)
  }
  
  override func didMoveToSuperview() {
    logI("didMoveToSuperview")
    super.didMoveToSuperview()
  }
  
  override func didAddSubview(_ subview: UIView) {
    logI("didAddSubview(_ subview: UIView)")
    super.didAddSubview(subview)
  }
  
  override func willRemoveSubview(_ subview: UIView) {
    logI("willRemoveSubview")
    super.willRemoveSubview(subview)
  }
  
  override func layoutSubviews() {
    logI("layoutSubviews")
    super.layoutSubviews()
  }
  
  #if DEBUG
  // Only override draw() if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func draw(_ rect: CGRect) {
    logI("draw(_ rect: CGRect)")
    super.draw(rect)
  }
  #endif
}
