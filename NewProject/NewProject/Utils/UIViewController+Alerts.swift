// UIViewController+Alerts.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh.

import Foundation
import UIKit

extension UIViewController {
  typealias VoidHandler = () -> Void
  typealias TextFieldHandler = ([UITextField]) -> Void
  typealias ActionHandler = ((UIAlertAction) -> Void)?

  struct TextFieldData {
    var text: String?
    var placeholder: String?
  }

  /// Show alert view controller with actions.
  ///
  /// - Parameters:
  ///   - title: alert title.
  ///   - message: alert message.
  ///   - textColor: text color.
  ///   - actions: action array.
  func showAlertWithActions(_ title: String?, message: String?, textColor: UIColor? = nil, actions: [UIAlertAction]) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title,
                                    message: message,
                                    preferredStyle: .alert)

      for action in actions {
        alert.addAction(action)
      }

      if let textColor = textColor {
        alert.view.tintColor = textColor
        self.present(alert, animated: true) {
          alert.view.tintColor = textColor
        }
      } else {
        self.present(alert, animated: true)
      }
    }
  }

  func showOKAlert(_ title: String?, message: String?, okTitle: String) {
    showAlertWithActions(title, message: message, actions: [UIAlertAction(title: okTitle, style: .default)])
  }

  func showOKAlert(_ title: String?,
                   message: String?,
                   okTitle: String,
                   okHandler: ((UIAlertAction) -> Void)? = nil) {
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: .alert)
    let okAction = UIAlertAction(title: okTitle, style: .default, handler: okHandler)
    alert.addAction(okAction)
    present(alert, animated: true)
  }

  /// Show alert view controller with textfields.
  ///
  /// - Parameters:
  ///   - title: alert title.
  ///   - message: alert message.
  ///   - textColor: text color.
  ///   - textFieldsData: textFieldsData array.
  ///   - okTitle: ok button title.
  ///   - cancelTitle: cancel button title.
  ///   - cancelHandler: ok button handler.
  ///   - okHandler: cancel button handler.
  func showAlertController(withTitle title: String?,
                           message: String?,
                           textColor: UIColor? = nil,
                           textFieldsData: [TextFieldData], cancelTitle: String,
                           cancelHandler: VoidHandler?,
                           okTitle: String,
                           okHandler: TextFieldHandler?) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title,
                                    message: message,
                                    preferredStyle: .alert)

      var textfields = [UITextField]()
      for textFieldData in textFieldsData {
        alert.addTextField { (textField) -> Void in
          textField.text = textFieldData.text
          textField.placeholder = textFieldData.placeholder
          textField.clearButtonMode = .whileEditing
          textfields.append(textField)
        }
      }

      let ok = UIAlertAction(title: okTitle, style: .default) { _ in
        okHandler?(textfields)
      }

      let cancel = UIAlertAction(title: cancelTitle, style: .default) { _ in
        cancelHandler?()
      }

      alert.addAction(ok)
      alert.addAction(cancel)

      if let textColor = textColor {
        alert.view.tintColor = textColor
        self.present(alert, animated: true) {
          alert.view.tintColor = textColor
        }
      } else {
        self.present(alert, animated: true)
      }
    }
  }

  func showAlertController(title: String,
                           message: String?,
                           okTitle: String,
                           cancelTitle: String,
                           okHandler: (() -> Void)? = nil,
                           cancelHandelr: (() -> Void)? = nil,
                           completion: (() -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

    let okAction = UIAlertAction(title: okTitle, style: .default) { (_) -> Void in
      okHandler?()
    }

    let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
      cancelHandelr?()
    }

    alertController.addAction(okAction)
    alertController.addAction(cancelAction)

    present(alertController, animated: true) { () -> Void in
      completion?()
    }
  }
}
