// AdvancedLogger.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh on 2019/9/18.

import DeviceGuru
import UIKit

class AdvancedLogger: BaseLogger {
  override func show(_ logString: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let logTextView = appDelegate.logTextView

    if logTextView.contentSize.height < logTextView.frame.size.height {
      logTextView.text += "\n\(logString)"
    } else {
      logTextView.text = logString
    }
  }

  override func cache(_ logString: String) {
    do {
      try FileManager.default.saveLog(logString)
    } catch {
      logE(error)
    }
  }
}

extension FileManager {
  var cachesDirectory: URL? {
    return urls(for: .cachesDirectory, in: .userDomainMask).first
  }

  func saveLog(_ logString: String) throws {
    guard let cachesDirectory = cachesDirectory else { return }
    let currentDateString = Date().toString(dateFormat: "yyyyMMdd")
    let filePath = cachesDirectory.appendingPathComponent("\(currentDateString).log")

    if fileExists(atPath: filePath.path) { // adding content to file
      let fileHandle = FileHandle(forWritingAtPath: filePath.path)
      let content = "\(logString)\n"
      fileHandle?.seekToEndOfFile()
      fileHandle?.write(content.data(using: .utf8) ?? Data())
    } else { // create new file
      do {
        let infoDictionary = Bundle.main.infoDictionary!
        let version = infoDictionary["CFBundleShortVersionString"]
        let buildNumber = infoDictionary["CFBundleVersion"]
        let header = "Version: \((version as? String)!)\nBuild Number: \((buildNumber as? String)!)\n"
        let APPVersionsHistory = "Versions History: " + UserDefaults.standard.APPVersionsHistory + "\n"
        let deviceGuru = DeviceGuru()
        let deviceName = deviceGuru.hardware()
        let deviceCode = deviceGuru.hardwareString()
        let platform = deviceGuru.platform()
        let deviceInfo = "\(deviceName) - \(deviceCode) - \(platform)\n"
        let content = header + APPVersionsHistory + deviceInfo + "\(logString)\n"
        try content.write(to: filePath, atomically: false, encoding: .utf8)
      } catch {
        throw error
      }
    }
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
