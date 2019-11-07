// NSPersistentContainerExtension.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh.

import CoreData
import HouLogger

extension NSPersistentContainer {
  func saveContext(backgroundContext: NSManagedObjectContext? = nil) throws {
    let context = backgroundContext ?? viewContext
    guard context.hasChanges else { return }
    do {
      try context.save()
    } catch {
      logE("", error: error)
      throw error
    }
  }
}
