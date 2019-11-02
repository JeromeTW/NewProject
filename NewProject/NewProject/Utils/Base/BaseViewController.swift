// BaseViewController.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh on 2019/9/18.

import UIKit

class BaseViewController: UIViewController {
  // MARK: - ViewController lifecycle
  deinit {
    logI("\(self.className) deinit")
  }
  
  override func loadView() {
    logI("\(self.className) loadView")
    super.loadView()
    
  }
  
  override func viewDidLoad() {
    logI("\(self.className) viewDidLoad")
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    logI("\(self.className) viewWillAppear:")
    super.viewWillAppear(animated)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    logI("\(self.className) viewDidAppear:")
    super.viewDidAppear(animated)
  }
  
  override func viewWillLayoutSubviews() {
    logI("\(self.className) viewWillLayoutSubviews")
    super.viewWillLayoutSubviews()
  }
  
  override func viewDidLayoutSubviews() {
    logI("\(self.className) viewDidLayoutSubviews")
    super.viewDidLayoutSubviews()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    logI("\(self.className) viewWillDisappear:")
    super.viewWillDisappear(animated)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    logI("\(self.className) viewDidDisappear:")
    super.viewDidDisappear(animated)
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    logI("\(self.className) viewWillTransition:")
    super.viewWillTransition(to: size, with: coordinator)
  }
  // MARK: - Inherit method
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}
