//
//  BaseViewController.swift
//  DDTDemo
//
//  Created by Allen Lai on 2019/7/29.
//  Copyright © 2019 Allen Lai. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  // MARK: - ViewController lifecycle

  deinit {
    logger.log("\(self.className) deinit")
  }

  override func loadView() {
    super.loadView()
    logger.log("\(className) loadView")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    logger.log("\(className) viewDidLoad")

    setupAuth()
    setupBaseUI()
    setupBinding()
    setupData()
    updateUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    logger.log("\(className) viewWillAppear:")
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    logger.log("\(className) viewDidAppear:")
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    logger.log("\(className) viewWillLayoutSubviews")
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    logger.log("\(className) viewDidLayoutSubviews")
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    logger.log("\(className) viewWillDisappear:")
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    logger.log("\(className) viewDidDisappear:")
  }

  // MARK: - Inherit method

  override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
    view.endEditing(true)
  }

  // MARK: - Public method

  func setupAuth() {
    logger.log("\(className) setupAuth")
  }

  func setupBaseUI() {
    logger.log("\(className) setupUI")

    view.backgroundColor = .white
    title = className
  }

  func setupBinding() {
    logger.log("\(className) setupBinding")
  }

  func setupData() {
    logger.log("\(className) setupData")
  }

  func updateUI() {
    logger.log("\(className) updateUI")
  }
}
