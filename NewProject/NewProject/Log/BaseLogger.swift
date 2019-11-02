// BaseLogger.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh.

import Foundation
import os

// MARK: - NOTE: Need DateExtension.swift file

enum LogLevel: Int, CustomStringConvertible {
  var description: String {
    switch self {
    case .fault:
      return "❌ Fault"
    case .error:
      return "‼️ Error"
    case .debug:
      return "🐌 Debug"
    case .info:
      return "📗 Info"
    case .normal:
      return "🍋 Default"
    }
  }

  case fault, error, debug, info, normal

  var theOSLogType: OSLogType {
    switch self {
    case .fault:
      return .fault
    case .error:
      return .error
    case .debug:
      return .debug
    case .info:
      return .info
    case .normal:
      return .default
    }
  }
}

#if TEST
  let logger = BaseLogger() // Test Target 要測試時用這個
#else
  let logger = AdvancedLogger() // APP Target 用這個，此包含 UI 和 Log 檔案儲存。
#endif

enum JeOSLog {
  static let subsystem = "me.jerome.Mod"
  case defaultLog, table, network, test, image
  var osLog: OSLog {
    switch self {
    case .table:
      return OSLog(subsystem: JeOSLog.subsystem, category: "table")
    case .defaultLog:
      return OSLog(subsystem: JeOSLog.subsystem, category: "default")
    case .network:
      return OSLog(subsystem: JeOSLog.subsystem, category: "network")
    case .test:
      return OSLog(subsystem: JeOSLog.subsystem, category: "test")
    case .image:
      return OSLog(subsystem: JeOSLog.subsystem, category: "image")
    }
  }
}

class BaseLogger {
  // MARK: - Properties

  private(set) var logLevels = [LogLevel]()
  private(set) var shouldShow = false
  private(set) var shouldCache = false

  init() {}

  // MARK: - Public method

  func configure(_ logLevels: [LogLevel], shouldShow: Bool = false, shouldCache: Bool = false) {
    self.logLevels = logLevels
    self.shouldShow = shouldShow
    self.shouldCache = shouldCache
  }

  func log(_ items: Any,
           theOSLog: JeOSLog = JeOSLog.defaultLog,
           level: LogLevel = .normal,
           file: String,
           function: String,
           line: Int) {
    #if DEBUG
      if logLevels.contains(level) {
        let fileName = file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
        let logString = "⭐️ [\(level.description)] [\(fileName).\(function):\(line)] > \(items)"

        os_log("%@", log: theOSLog.osLog, type: level.theOSLogType, logString)

        if shouldShow {
          show(logString)
        }

        if shouldCache {
          cache(logString)
        }
      }
    #endif
  }

  func show(_: String) {} // 在 AdvancedLogger 中實作
  func cache(_: String) {} // 在 AdvancedLogger 中實作
}

func logF(_ items: Any,
          theOSLog: JeOSLog = JeOSLog.defaultLog,
          file: String = #file,
          function: String = #function,
          line: Int = #line) {
  logger.log(items, theOSLog: theOSLog, level: .fault, file: file, function: function, line: line)
  // Need to import Crashlytics
  //  Crashlytics.sharedInstance().recordError(error, withAdditionalUserInfo: ["msg":"\(items)"])
}

func logE(_ items: Any,
          theOSLog: JeOSLog = JeOSLog.defaultLog,
          file: String = #file,
          function: String = #function,
          line: Int = #line) {
  logger.log(items, theOSLog: theOSLog, level: .error, file: file, function: function, line: line)
  // Need to import Crashlytics
  // Crashlytics.sharedInstance().recordError(error, withAdditionalUserInfo: ["msg":"\(items)"])
}

func logE(_ error: Error,
          theOSLog: JeOSLog = JeOSLog.defaultLog,
          file: String = #file,
          function: String = #function,
          line: Int = #line) {
  logger.log("Error: \(error.localizedDescription)", theOSLog: theOSLog, level: .error, file: file, function: function, line: line)
  // Need to import Crashlytics
  // Crashlytics.sharedInstance().recordError(error, withAdditionalUserInfo: ["msg":error.localizedDescription])
}

func logD(_ items: Any,
          theOSLog: JeOSLog = JeOSLog.defaultLog,
          file: String = #file,
          function: String = #function,
          line: Int = #line) {
  logger.log(items, theOSLog: theOSLog, level: .debug, file: file, function: function, line: line)
}

func logI(_ items: Any,
          theOSLog: JeOSLog = JeOSLog.defaultLog,
          file: String = #file,
          function: String = #function,
          line: Int = #line) {
  logger.log(items, theOSLog: theOSLog, level: .info, file: file, function: function, line: line)
}

func logN(_ items: Any,
          theOSLog: JeOSLog = JeOSLog.defaultLog,
          file: String = #file,
          function: String = #function,
          line: Int = #line) {
  logger.log(items, theOSLog: theOSLog, level: .normal, file: file, function: function, line: line)
}
