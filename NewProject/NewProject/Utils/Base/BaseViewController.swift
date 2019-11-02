// BaseViewController.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh.

import UIKit

class BaseViewController: UIViewController {
  // MARK: - ViewController lifecycle

  deinit {
    logI("\(self.className) deinit")
  }

  override func loadView() {
    logI("\(className) loadView")
    super.loadView()
  }

  override func viewDidLoad() {
    logI("\(className) viewDidLoad")
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    logI("\(className) viewWillAppear:")
    super.viewWillAppear(animated)
  }

  override func viewDidAppear(_ animated: Bool) {
    logI("\(className) viewDidAppear:")
    super.viewDidAppear(animated)
  }

  override func viewWillLayoutSubviews() {
    logI("\(className) viewWillLayoutSubviews")
    super.viewWillLayoutSubviews()
  }

  override func viewDidLayoutSubviews() {
    logI("\(className) viewDidLayoutSubviews")
    super.viewDidLayoutSubviews()
  }

  override func viewWillDisappear(_ animated: Bool) {
    logI("\(className) viewWillDisappear:")
    super.viewWillDisappear(animated)
  }

  override func viewDidDisappear(_ animated: Bool) {
    logI("\(className) viewDidDisappear:")
    super.viewDidDisappear(animated)
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    logI("\(className) viewWillTransition:")
    super.viewWillTransition(to: size, with: coordinator)
  }

  // MARK: - Inherit method

  override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
    view.endEditing(true)
  }
}
