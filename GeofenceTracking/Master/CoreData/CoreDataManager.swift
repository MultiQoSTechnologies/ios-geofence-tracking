//
//  CoreDataManager.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import CoreData

/// A class is responsible for save coredata related changes on disk.
/// Don't try to access properties of this class outside its scope.
final class CoreDataManager {
    
    static let shared: CoreDataManager = CoreDataManager()

    // MARK: - CoreData Stack -
    
    /// A PersistentContainer object, Please don't forgot to initialize it with Coredata model name.
    /// Please find it in bundle, App.xcdatamodeld ==> `App` would be name.
    fileprivate lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "noble")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    /// mainManagedObjectContext.
    lazy private(set) var mainManagedObjectContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    /// NSPersistentStoreCoordinator.
    lazy private(set) var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        return persistentContainer.persistentStoreCoordinator
    }()
    
    
    // MARK: - Multiple MOC -
    
    /// privateMangedObjectContext, Used for MOC concept(Private Queue).
    lazy private(set) var privateMangedObjectContext: NSManagedObjectContext = {
        
        let privateMangedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMangedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        return privateMangedObjectContext
    }()
    
    /// mediatorMangedObjectContext, Used for MOC concept(Main Queue).
    lazy private(set) var mediatorMangedObjectContext: NSManagedObjectContext = {
        
        let mediatorMangedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mediatorMangedObjectContext.parent = privateMangedObjectContext
        return mediatorMangedObjectContext
    }()
    
    /// childMangedObjectContext, Used for MOC concept(Private Queue).
    lazy private(set) var childMangedObjectContext: NSManagedObjectContext = {
        
        let childMangedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        childMangedObjectContext.parent = mediatorMangedObjectContext
        return childMangedObjectContext
    }()
    
}

// MARK: -
// MARK: - Save Methods, Only access below two.
extension CoreDataManager {
    
    /// Save all coredata related changes by this method if number of datas are in small amount.
    /// Usage: CoreDataManager.shared.save().
    func save() {
        mainManagedObjectContext.saveChanges()
    }
    
    /// Save all coredata related changes by this method if number of datas are in large amount and you don't want be block your app UI.
    /// Usage: CoreDataManager.shared.saveChangesOnMultipleMOC().
    func saveChangesOnMultipleMOC() {
        
        NSManagedObjectContext.saveChangesOnMultipleMOC(withManagedObjectContext: childMangedObjectContext, mediatorMangedObjectContext: mediatorMangedObjectContext, privateManagedObjectContext: privateMangedObjectContext)
    }
}
