// BaseViewController.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh on 2019/9/18.

import UIKit

class BaseViewController: UIViewController {
  // MARK: - ViewController lifecycle
  deinit {
    logger.log("\(self.className) deinit")
  }
  
  override func loadView() {
    logger.log("\(self.className) loadView")
    super.loadView()
    
  }
  
  override func viewDidLoad() {
    logger.log("\(self.className) viewDidLoad")
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    logger.log("\(self.className) viewWillAppear:")
    super.viewWillAppear(animated)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    logger.log("\(self.className) viewDidAppear:")
    super.viewDidAppear(animated)
  }
  
  override func viewWillLayoutSubviews() {
    logger.log("\(self.className) viewWillLayoutSubviews")
    super.viewWillLayoutSubviews()
  }
  
  override func viewDidLayoutSubviews() {
    logger.log("\(self.className) viewDidLayoutSubviews")
    super.viewDidLayoutSubviews()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    logger.log("\(self.className) viewWillDisappear:")
    super.viewWillDisappear(animated)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    logger.log("\(self.className) viewDidDisappear:")
    super.viewDidDisappear(animated)
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    logger.log("\(self.className) viewWillTransition:")
    super.viewWillTransition(to: size, with: coordinator)
  }
  // MARK: - Inherit method
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}
