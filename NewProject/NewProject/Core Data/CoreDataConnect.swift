// CoreDataConnect.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh on 2019/9/18.

import CoreData
import UIKit

class CoreDataConnect {
  lazy var persistentContainer: NSPersistentContainer = {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer
  }()

  var myContext: NSManagedObjectContext!

  init(context: NSManagedObjectContext) {
    myContext = context
  }

  init() { // Use viewContext
    myContext = UIApplication.viewContext
  }

  // MARK: - Functions

  // insert
  // NOTE: myEntityName(在Video.xcdatamodeld中設定) 必須跟 class name 一致才能用範型
  func insert<T: NSManagedObject>(type _: T.Type, attributeInfo: [String: Any]) throws {
    let insetObject = NSEntityDescription.insertNewObject(forEntityName: String(describing: T.self), into: myContext)

    for (key, value) in attributeInfo {
      insetObject.setValue(value, forKey: key)
    }

    try persistentContainer.saveContext(backgroundContext: myContext)
  }

  // retrieve
  func retrieve<T: NSManagedObject>(type _: T.Type, predicate: NSPredicate?, sort: [[String: Bool]]?, limit: Int?) -> [T]? {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))

    // predicate
    request.predicate = predicate

    // sort
    if let mySort = sort {
      var sortArr: [NSSortDescriptor] = []
      for sortCond in mySort {
        for (key, value) in sortCond {
          sortArr.append(NSSortDescriptor(key: key, ascending: value))
        }
      }

      request.sortDescriptors = sortArr
    }

    // limit
    if let limitNumber = limit {
      request.fetchLimit = limitNumber
    }

    do {
      return try myContext.fetch(request) as? [T]

    } catch {
      fatalError("\(error)")
    }
  }

  // update
  func update<T: NSManagedObject>(type: T.Type, predicate: NSPredicate?, limit: Int? = 1, attributeInfo: [String: Any]) throws {
    if let results = self.retrieve(type: type, predicate: predicate, sort: nil, limit: limit) {
      for result in results {
        for (key, value) in attributeInfo {
          result.setValue(value, forKey: key)
        }
      }
      try persistentContainer.saveContext(backgroundContext: myContext)
    }
  }

  // delete
  func delete<T: NSManagedObject>(type: T.Type, predicate: NSPredicate?) throws {
    if let results = self.retrieve(type: type, predicate: predicate, sort: nil, limit: nil) {
      for result in results {
        myContext.delete(result)
      }

      try persistentContainer.saveContext(backgroundContext: myContext)
    }
  }

  func getCount<T: NSManagedObject>(type _: T.Type, predicate: NSPredicate?) -> Int {
    var count = 0
    let request = NSFetchRequest<NSNumber>(entityName: String(describing: T.self))

    // predicate
    request.predicate = predicate
    request.resultType = .countResultType

    do {
      let countResult = try myContext.fetch(request)
      // 获取数量
      count = countResult.first!.intValue
    } catch let error as NSError {
      assertionFailure("Could not fetch \(error), \(error.userInfo)")
    }
    return count
  }

  public func getFRC<T: NSManagedObject>(type _: T.Type, predicate: NSPredicate? = nil, sortDescriptors:
    [NSSortDescriptor]? = nil, limit: Int? = nil, sectionNameKeyPath: String? = nil, cacheName: String? = nil) -> NSFetchedResultsController<T> {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))

    // predicate
    request.predicate = predicate
    // sort
    request.sortDescriptors = sortDescriptors

    // limit
    if let limitNumber = limit {
      request.fetchLimit = limitNumber
    }
    let fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: myContext,
                                                              sectionNameKeyPath: sectionNameKeyPath,
                                                              cacheName: cacheName) as! NSFetchedResultsController<T>
    do {
      try fetchedResultsController.performFetch()
    } catch {
      let fetchError = error as NSError
      logger.log("\(fetchError), \(fetchError.userInfo)", level: .error)
    }

    return fetchedResultsController
  }
}

protocol HasID {
  var id: Int64 { get set }
}

// MARK: - HasID

extension CoreDataConnect {
  // This Entity must has id property
  func generateNewID<T: HasID>(_: T.Type) -> Int64 {
    var newID: Int64 = 1
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
    request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
    request.fetchLimit = 1

    do {
      let result = try myContext.fetch(request) as? [T]
      if let first = result?.first {
        newID = first.id + 1
      }
      return newID
    } catch {
      fatalError("\(error)")
    }
  }
}

// MARK: - HasOrder

protocol HasOrder {
  var order: Int64 { get set }
}

extension CoreDataConnect {
  // This Entity must has order property
  func generateNewOrder<T: HasOrder>(_: T.Type) -> Int64 {
    var newOrder: Int64 = 1
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
    request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: false)]
    request.fetchLimit = 1

    do {
      let result = try myContext.fetch(request) as? [T]
      if let first = result?.first {
        newOrder = first.order + 1
      }
      return newOrder
    } catch {
      fatalError("\(error)")
    }
  }
}
