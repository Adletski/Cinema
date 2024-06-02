// CoreDataManager.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    lazy var context = persistentContainer.viewContext
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CinemaStar")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                print("Persistent container error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Failed to save context \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
