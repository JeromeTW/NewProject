// NSPersistentContainerExtension.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh on 2019/9/18.

import CoreData

extension NSPersistentContainer {
  func saveContext(backgroundContext: NSManagedObjectContext? = nil) throws {
    let context = backgroundContext ?? viewContext
    guard context.hasChanges else { return }
    do {
      try context.save()
    } catch {
      logE(error)
      throw error
    }
  }
}
