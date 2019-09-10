//
//  LogLevelConfigurator.swift
//  TaiChungWeather
//
//  Created by JEROME on 2019/7/29.
//  Copyright © 2019 JEROME. All rights reserved.
//

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

class LogLevelConfigurator {
  // MARK: - Properties

  static let shared = LogLevelConfigurator()
  private(set) var logLevels = [LogLevel]()
  private(set) var shouldShow = false
  private(set) var shouldCache = false

  // MARK: - Initializer

  private init() {}

  // MARK: - Public method

  func configure(_ logLevels: [LogLevel], shouldShow: Bool = false, shouldCache: Bool = false) {
    self.logLevels = logLevels
    self.shouldShow = shouldShow
    self.shouldCache = shouldCache
  }
}
