// AppDelegate.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh on 2019/9/18.

import CoreData
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  lazy var logTextView: LogTextView = {
    let logTextView = LogTextView(frame: .zero)
    logTextView.layer.zPosition = .greatestFiniteMagnitude
    return logTextView
  }()

  func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    UserDefaults.standard.setAPPVersionAndHistory()
    setupLogConfigure()
    logger.log("\(self.className) willFinishLaunchingWithOptions")
    logger.log("NSHomeDirectory:\(NSHomeDirectory())", level: .debug)
    setupWindow()
    setupLogTextView()
    return true
  }
  
  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    logger.log("\(self.className) didFinishLaunchingWithOptions")
    setupCoreDataDB()
    return true
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    logger.log("\(self.className) applicationDidBecomeActive")
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    logger.log("\(self.className) applicationWillResignActive")
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    logger.log("\(self.className) openURLoptions")
    return true
  }
  
  func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
    logger.log("\(self.className) applicationDidReceiveMemoryWarning")
  }
  
  func applicationWillTerminate(_: UIApplication) {
    logger.log("\(self.className) applicationWillTerminate")
    do {
      try persistentContainer.saveContext()
    } catch {
      logger.log("Error:\(error.localizedDescription)", level: .error)
    }
  }
  
  // MARK: - StatusBar
  
  func application(_ application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    logger.log("\(self.className) willChangeStatusBarOrientation")
  }
  
  func application(_ application: UIApplication, didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {
    logger.log("\(self.className) didChangeStatusBarOrientation")
  }
  
  func application(_ application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {
    logger.log("\(self.className) willChangeStatusBarFrame")
  }
  
  func application(_ application: UIApplication, didChangeStatusBarFrame oldStatusBarFrame: CGRect) {
    logger.log("\(self.className) didChangeStatusBarFrame")
  }
  
  // MARK: - Notifications
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    logger.log("\(self.className) didRegisterForRemoteNotificationsWithDeviceToken")
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    logger.log("\(self.className) didFailToRegisterForRemoteNotificationsWithError")
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
    logger.log("\(self.className) didReceiveRemoteNotification")
  }
  
  // MARK: - Background
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    logger.log("\(self.className) applicationDidEnterBackground")
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    logger.log("\(self.className) applicationWillEnterForeground")
  }
  
  func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool{
    return true
  }
  
  private func setupWindow() {
    window = UIWindow(frame: UIScreen.main.bounds)
    guard let window = window else { fatalError() }
    // TODO: Need to implentation
    window.rootViewController = MainTabBarController()
    window.makeKeyAndVisible()
  }

  

  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    let container = NSPersistentContainer(name: "Video")
    container.loadPersistentStores(completionHandler: { _, error in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()

  lazy var viewContext: NSManagedObjectContext = {
    persistentContainer.viewContext
  }()

  private func setupCoreDataDB() {}
}

// MARK: - Log

extension AppDelegate {
  private func setupLogConfigure() {
    logger.configure([.fault, .error, .debug, .info], shouldShow: false, shouldCache: true)
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

extension UIApplication {
  static var viewContext: NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.viewContext
  }
}
