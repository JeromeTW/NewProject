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
    logger.log("init?(coder: NSCoder)")
    super.init(coder: coder)
  }
  
  override init(frame: CGRect) {
    logger.log("init(frame: NSCoder)")
    super.init(frame: frame)
  }
  
  override func awakeFromNib() {
    logger.log("awakeFromNib")
    super.awakeFromNib()
  }
  
  override func willMove(toWindow newWindow: UIWindow?) {
    logger.log("willMove(toWindow newWindow: UIWindow?)")
    super.willMove(toWindow: newWindow)
  }
  
  override func didMoveToWindow() {
    logger.log("didMoveToWindow")
    super.didMoveToWindow()
  }
  
  override func willMove(toSuperview newSuperview: UIView?) {
    logger.log("willMove(toSuperview newSuperview: UIView?)")
    super.willMove(toSuperview: newSuperview)
  }
  
  override func didMoveToSuperview() {
    logger.log("didMoveToSuperview")
    super.didMoveToSuperview()
  }
  
  override func didAddSubview(_ subview: UIView) {
    logger.log("didAddSubview(_ subview: UIView)")
    super.didAddSubview(subview)
  }
  
  override func willRemoveSubview(_ subview: UIView) {
    logger.log("willRemoveSubview")
    super.willRemoveSubview(subview)
  }
  
  override func layoutSubviews() {
    logger.log("layoutSubviews")
    super.layoutSubviews()
  }
  
  #if DEBUG
  // Only override draw() if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func draw(_ rect: CGRect) {
    logger.log("draw(_ rect: CGRect)")
    super.draw(rect)
  }
  #endif
}
