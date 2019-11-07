// AppDelegate.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh.

import HouLogger
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  lazy var logTextView: LogTextView = {
    let logTextView = LogTextView(frame: .zero)
    logTextView.layer.zPosition = .greatestFiniteMagnitude
    return logTextView
  }()

  lazy var persistentContainerManager = PersistentContainerManager.shared

  func application(_ application: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    UserDefaults.standard.setAPPVersionAndHistory()
    setupLogConfigure()
    logC("NSHomeDirectory:\(NSHomeDirectory())")
    persistentContainerManager.setupCoreDataDB()
    #if TEST
      logC("🌘 TEST")
      setupWindow(rootViewController: UIViewController())
      return true
    #else
      logC("🌘 NOT TEST")
      setupWindow(rootViewController: MainTabBarController())
      setupLogTextView()
      return true
    #endif
  }

  // MARK: - Private method

  private func setupWindow(rootViewController: UIViewController) {
    window = UIWindow(frame: UIScreen.main.bounds)
    guard let window = window else { fatalError() }
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
  }

  func applicationWillTerminate(_: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    do {
      try persistentContainerManager.persistentContainer.saveContext()
    } catch {
      logE("", error: error)
    }
  }
}

// MARK: - Log

extension AppDelegate {
  private func setupLogConfigure() {
    logger.configure(shouldShow: false, shouldCache: true)
  }

  private func setupLogTextView() {
    #if DEBUG
      guard let window = window else { return }
      guard logger.shouldShow else { return }

      if #available(iOS 11.0, *) {
        window.addSubview(logTextView, constraints: [
          UIView.anchorConstraintEqual(from: \UIView.topAnchor, to: \UIView.safeAreaLayoutGuide.topAnchor, constant: .defaultMargin),
          UIView.anchorConstraintEqual(from: \UIView.leadingAnchor, to: \UIView.safeAreaLayoutGuide.leadingAnchor, constant: .defaultMargin),
          UIView.anchorConstraintEqual(from: \UIView.bottomAnchor, to: \UIView.safeAreaLayoutGuide.bottomAnchor, constant: CGFloat.defaultMargin.negativeValue),
          UIView.anchorConstraintEqual(from: \UIView.trailingAnchor, to: \UIView.safeAreaLayoutGuide.trailingAnchor, constant: CGFloat.defaultMargin.negativeValue),
        ])
      } else {
        window.addSubview(logTextView, constraints: [
          UIView.anchorConstraintEqual(with: \UIView.topAnchor, constant: .defaultMargin),
          UIView.anchorConstraintEqual(with: \UIView.leadingAnchor, constant: .defaultMargin),
          UIView.anchorConstraintEqual(with: \UIView.bottomAnchor, constant: CGFloat.defaultMargin.negativeValue),
          UIView.anchorConstraintEqual(with: \UIView.trailingAnchor, constant: CGFloat.defaultMargin.negativeValue),
        ])
      }
    #endif
  }
}
