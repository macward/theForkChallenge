//
//  LocalStorageStack.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//

import Foundation
import CoreData

class CoreDataStack {
    
    private init() {}
    
    static let shared = CoreDataStack()
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TheForkTest")
        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                fatalError("error creating store container")
            }
        }
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    @discardableResult
    func saveContext() async throws -> Bool {
        
        guard context.hasChanges else {
            return false
        }
        do {
            try self.context.save()
            return true
        } catch {
            print("Gemeral error<")
            return false
        }
    }
    
    func fetch<T: NSManagedObject>(_ request: NSFetchRequest<T>) async throws -> [T]? {
        let results = try? self.context.fetch(request)
        return results
    }

}
