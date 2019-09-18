// LogTextView.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh on 2019/9/18.

/// NOTE: Work with CGFloatExtension.swift file.
import UIKit

class LogTextView: UITextView {
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)

    setupStyle()
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func hitTest(_: CGPoint, with _: UIEvent?) -> UIView? {
    return nil
  }

  private func setupStyle() {
    backgroundColor = .white
    alpha = 0.7
    textColor = .black
  }
}

extension UIView {
  typealias Constraint = (_ subview: UIView, _ superview: UIView) -> NSLayoutConstraint

  func addSubview(_ subview: UIView, constraints: [Constraint]) {
    addSubview(subview)
    subview.translatesAutoresizingMaskIntoConstraints = false
    addConstraints(constraints.map { $0(subview, self) })
  }

  /// ex: subview.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: constant)
  /// - Parameter subviewKeyPath: subview's KeyPath
  /// - Parameter superviewKeyPath: superview's KeyPath
  /// - Parameter constant: anchors distance constant
  static func anchorConstraintEqual<LayoutAnchor, Axis>(from subviewKeyPath: KeyPath<UIView, LayoutAnchor>,
                                                        to superviewKeyPath: KeyPath<UIView, LayoutAnchor>,
                                                        constant: CGFloat = 0.0) -> Constraint where LayoutAnchor: NSLayoutAnchor<Axis> {
    return { subview, superview in
      subview[keyPath: subviewKeyPath]
        .constraint(equalTo: superview[keyPath: superviewKeyPath],
                    constant: constant)
    }
  }

  /// ex: subview.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant)
  /// - Parameter viewKeyPath: subview's and superview's KeyPath
  /// - Parameter constant: anchors distance constant
  static func anchorConstraintEqual<LayoutAnchor, Axis>(with viewKeyPath: KeyPath<UIView, LayoutAnchor>,
                                                        constant: CGFloat = 0.0) -> Constraint where LayoutAnchor: NSLayoutAnchor<Axis> {
    return anchorConstraintEqual(from: viewKeyPath,
                                 to: viewKeyPath,
                                 constant: constant)
  }
}
