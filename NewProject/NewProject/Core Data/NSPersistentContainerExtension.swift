//
//  PersistentContainer.swift
//  TaiChungWeather
//
//  Created by JEROME on 2019/9/4.
//  Copyright © 2019 jerome. All rights reserved.
//

import CoreData

extension NSPersistentContainer {
  func saveContext(backgroundContext: NSManagedObjectContext? = nil) throws {
    let context = backgroundContext ?? viewContext
    guard context.hasChanges else { return }
    do {
      try context.save()
    } catch {
      logger.log("Error: \(error.localizedDescription)", level: .error)
      throw error
    }
  }
}
