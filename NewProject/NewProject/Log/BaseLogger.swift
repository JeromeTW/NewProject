// BaseLogger.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh on 2019/9/18.

import Foundation

enum LogLevel: Int, CustomStringConvertible {
  var description: String {
    switch self {
    case .error:
      return "‼️ Error"
    case .warning:
      return "⚠️ Warning"
    case .debug:
      return "🐌 Debug"
    case .info:
      return "📗 Info"
    }
  }

  case error, warning, debug, info
}

#if TEST
  let logger = BaseLogger() // Test Target 要測試時用這個
#else
  let logger = AdvancedLogger() // APP Target 用這個，此包含 UI 和 Log 檔案儲存。
#endif

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
           level: LogLevel = .info,
           file: String = #file,
           function: String = #function,
           line: Int = #line) {
    #if DEBUG
      if logLevels.contains(level) {
        let currentDateString = Date().toString()
        let fileName = file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
        let logString = "⭐️ [\(currentDateString)][\(level.description)] [\(fileName).\(function):\(line)] > \(items)"

        print(logString)

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

extension Date {
  func toString(dateFormat: String = "yyyy-MM-dd HH:mm:ss.SSS") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: self)
  }
}
