// BaseViewController.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh.

import HouLogger
import UIKit

class BaseViewController: UIViewController {
  // MARK: - ViewController lifecycle

  deinit {
    logC("\(self.className) deinit")
  }

  override func loadView() {
    logC("\(className) loadView")
    super.loadView()
  }

  override func viewDidLoad() {
    logC("\(className) viewDidLoad")
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    logC("\(className) viewWillAppear:")
    super.viewWillAppear(animated)
  }

  override func viewDidAppear(_ animated: Bool) {
    logC("\(className) viewDidAppear:")
    super.viewDidAppear(animated)
  }

  override func viewWillLayoutSubviews() {
    logC("\(className) viewWillLayoutSubviews")
    super.viewWillLayoutSubviews()
  }

  override func viewDidLayoutSubviews() {
    logC("\(className) viewDidLayoutSubviews")
    super.viewDidLayoutSubviews()
  }

  override func viewWillDisappear(_ animated: Bool) {
    logC("\(className) viewWillDisappear:")
    super.viewWillDisappear(animated)
  }

  override func viewDidDisappear(_ animated: Bool) {
    logC("\(className) viewDidDisappear:")
    super.viewDidDisappear(animated)
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    logC("\(className) viewWillTransition:")
    super.viewWillTransition(to: size, with: coordinator)
  }

  // MARK: - Inherit method

  override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
    view.endEditing(true)
  }
}
