//
//  PrintLog.swift
//  TaiChungWeather
//
//  Created by JEROME on 2019/7/29.
//  Copyright © 2019 JEROME. All rights reserved.
//

import UIKit

func printLog(_ items: Any,
              level: LogLevel = .info,
              file: String = #file,
              function: String = #function,
              line: Int = #line) {
  #if DEBUG
  if LogLevelConfigurator.shared.logLevels.contains(level) {
    let currentDateString = Date().toString()
    let fileName = file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
    let logString = "⭐️ [\(currentDateString)][\(level.description)] \(fileName).\(function):\(line) ~ \(items)"

    print(logString)

    if LogLevelConfigurator.shared.shouldShow {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
      let logTextView = appDelegate.logTextView

      if logTextView.contentSize.height < logTextView.frame.size.height {
        logTextView.text += "\n\(logString)"
      } else {
        logTextView.text = logString
      }
    }

    if LogLevelConfigurator.shared.shouldCache {
      do {
        try logString.saveLog()
      } catch {
        printLog(error.localizedDescription, level: .error)
      }
    }
  }
  #endif
}

extension Date {
  func toString(dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: self)
  }
}

extension String {
  func saveLog() throws {
    guard let cachesDirectory = FileManager.cachesDirectory else { return }
    let currentDateString = Date().toString(dateFormat: "yyyyMMdd")
    let filePath = cachesDirectory.appendingPathComponent("\(currentDateString).log")
    
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: filePath.path) { // adding content to file
      let fileHandle = FileHandle(forWritingAtPath: filePath.path)
      let content = "\(self)\n"
      fileHandle?.seekToEndOfFile()
      fileHandle?.write(content.data(using: .utf8) ?? Data())
    } else { // create new file
      do {
        let infoDictionary = Bundle.main.infoDictionary!
        let version = infoDictionary["CFBundleShortVersionString"] as? AnyObject
        let buildNumber = infoDictionary["CFBundleVersion"] as? AnyObject
        let header = "Version: \((version as? String)!)\nBuild Number: \((buildNumber as? String)!)\n"
        let APPVersionsHistory = "Versions History: " + UserDefaults.standard.APPVersionsHistory + "\n"
        let content = header + APPVersionsHistory + "\(self)\n"
        try content.write(to: filePath, atomically: false, encoding: .utf8)
      } catch {
        throw error
      }
    }
  }
}

extension FileManager {
  static var cachesDirectory: URL? {
    return `default`.urls(for: .cachesDirectory, in: .userDomainMask).first
  }
}

extension UserDefaults {
  var version: String {
    let infoDictionary = Bundle.main.infoDictionary!
    return infoDictionary["CFBundleShortVersionString"] as! String
  }
  
  func setAPPVersionAndHistory() {
    let historyKey = "APPVersionsHistory"
    if var versionHistory = self.string(forKey: historyKey) {
      if lastVersion != version {
        // 如果版本號不同了，記錄在 APPVersionsHistory 中。
        versionHistory += " -> \(version)"
        set(versionHistory, forKey: historyKey)
      }
    } else {
      set(version, forKey: historyKey)
    }
    setAPPVersion()
  }
  
  var APPVersionsHistory: String {
    let key = "APPVersionsHistory"
    guard let result = string(forKey: key) else {
      assertionFailure("Not set APPVersionsHistory")
      return ""
    }
    return result
  }
  
  private func setAPPVersion() {
    let key = "APPVersion"
    set(version, forKey: key)
  }
  
  var lastVersion: String? {
    let key = "APPVersion"
    return string(forKey: key)
  }
}
