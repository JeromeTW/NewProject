// BaseView.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh.

import UIKit

class BaseView: UIView {
  required init?(coder: NSCoder) {
    logC("init?(coder: NSCoder)")
    super.init(coder: coder)
  }

  override init(frame: CGRect) {
    logC("init(frame: NSCoder)")
    super.init(frame: frame)
  }

  override func awakeFromNib() {
    logC("awakeFromNib")
    super.awakeFromNib()
  }

  override func willMove(toWindow newWindow: UIWindow?) {
    logC("willMove(toWindow newWindow: UIWindow?)")
    super.willMove(toWindow: newWindow)
  }

  override func didMoveToWindow() {
    logC("didMoveToWindow")
    super.didMoveToWindow()
  }

  override func willMove(toSuperview newSuperview: UIView?) {
    logC("willMove(toSuperview newSuperview: UIView?)")
    super.willMove(toSuperview: newSuperview)
  }

  override func didMoveToSuperview() {
    logC("didMoveToSuperview")
    super.didMoveToSuperview()
  }

  override func didAddSubview(_ subview: UIView) {
    logC("didAddSubview(_ subview: UIView)")
    super.didAddSubview(subview)
  }

  override func willRemoveSubview(_ subview: UIView) {
    logC("willRemoveSubview")
    super.willRemoveSubview(subview)
  }

  override func layoutSubviews() {
    logC("layoutSubviews")
    super.layoutSubviews()
  }

  #if DEBUG
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
      logC("draw(_ rect: CGRect)")
      super.draw(rect)
    }
  #endif
}
