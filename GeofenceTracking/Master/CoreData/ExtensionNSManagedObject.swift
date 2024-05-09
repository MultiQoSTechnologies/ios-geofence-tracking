//
//  ExtensionNSManagedObject.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    /// Entity Name (TblUser).
    static var entityName: String {
        return (NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last ?? "")
    }
    /// NSEntityDescription.
    static var entityDescription: NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: entityName, in: mainManagedObjectContext)
    }
    
    // MARK: - CoreData Stack. -
    
    /// mainManagedObjectContext (Access from CoreDataManager class).
    static private var mainManagedObjectContext: NSManagedObjectContext {
        return CoreDataManager.shared.mainManagedObjectContext
    }
    
    /// NSPersistentStoreCoordinator (Access from CoreDataManager class).
    static private var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        return CoreDataManager.shared.persistentStoreCoordinator
    }
    
    // MARK: - Multiple MOC. -
    
    /// privateMangedObjectContext, Used for MOC concept(Private Queue), (Access from CoreDataManager class).
    static private var privateMangedObjectContext: NSManagedObjectContext {
        return CoreDataManager.shared.privateMangedObjectContext
    }
    /// mediatorMangedObjectContext, Used for MOC concept(Main Queue), (Access from CoreDataManager class).
    static private var mediatorMangedObjectContext: NSManagedObjectContext {
        return CoreDataManager.shared.mediatorMangedObjectContext
    }
    /// childMangedObjectContext, Used for MOC concept(Private Queue), (Access from CoreDataManager class).
    static private var childMangedObjectContext: NSManagedObjectContext {
        return CoreDataManager.shared.childMangedObjectContext
    }
    
    
    // MARK: - CRUD. -
    
    /// fetchRequest(NSFetchRequest), Used for create, fetch and delete operations.
    static var fetchRequest: NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        return fetchRequest
    }
    /// batchUpdateRequest(NSBatchUpdateRequest), Used for batch update operation.
    fileprivate static var batchUpdateRequest: NSBatchUpdateRequest {
        if let entityDescription = entityDescription {
            return NSBatchUpdateRequest(entity: entityDescription)
        } else {
            return NSBatchUpdateRequest(entityName: entityName)
        }
    }
    /// batchDeleteRequest(NSBatchDeleteRequest), Used for batch delete operation.
    fileprivate static var batchDeleteRequest: NSBatchDeleteRequest {
        return NSBatchDeleteRequest(fetchRequest: fetchRequest)
    }
}

// MARK: - Helper methods. -
extension NSManagedObject {
    
    /// A fileprivate method used to convert the dictionary into predicate.
    /// - Parameter dict: Pass the dictionary to which you convert into predicate.
    fileprivate static func dictToPredicate(withDictionary dict: [String: Any]) -> NSPredicate {
        
        var arrPredicates = [NSPredicate]()
        for (key, value) in dict {
            arrPredicates.append(NSPredicate(format: "%K == %@", key, ((value as? NSObject) ?? "")))
        }
        return NSCompoundPredicate(andPredicateWithSubpredicates: arrPredicates)
    }
}

// MARK: - FindOrCreate methods. -
extension NSManagedObject {
    
    /// A method used to find `OR` create the Entity object on mainManagedObjectContext.
    /// - Parameter dict: Pass the dictionary with any default, fixed value, you can pass the blank dictionary `[:]` as well.
    static func findOrCreate(withDictionary dict: [String: Any]) -> NSManagedObject {
        
        guard let managedObject = findoutManagedObject(withDictionary: dict, context: mainManagedObjectContext) else {
            return createManagedObject(withDictionary: dict, context: mainManagedObjectContext)
        }
        return managedObject
    }
    
    /// A method used to find `OR` create the Entity object with multiple MOC.
    /// - Parameter dict: Pass the dictionary with any default, fixed value, you can pass the blank dictionary `[:]` as well.
    static func findOrCreateWithMultipleMOC(withDictionary dict: [String: Any]) -> NSManagedObject {
        
        guard let managedObject = findoutManagedObject(withDictionary: dict, context: childMangedObjectContext) else {
            return createManagedObject(withDictionary: dict, context: childMangedObjectContext)
        }
        
        return managedObject
    }
    
    /// A fileprivate method used to find the Entity object.
    fileprivate static func findoutManagedObject(withDictionary dict: [String: Any], context: NSManagedObjectContext) -> NSManagedObject? {
        
        let fRequest = fetchRequest
        fRequest.predicate = dictToPredicate(withDictionary: dict)
        
        do { return try context.fetch(fRequest).last as? NSManagedObject }
            
        catch {
            AppLogs.debugPrint("Error while finding the NSManagedObject with dict :- \(dict) AND error is :- \(error.localizedDescription)")
        }
        return nil
    }
    
    /// A fileprivate method used to created the Entity object.
    fileprivate static func createManagedObject(withDictionary dict: [String: Any], context: NSManagedObjectContext) -> NSManagedObject {
        
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        
        if let attributes = entityDescription?.attributesByName {
            for (key , _) in attributes {
                managedObject.setValue(dict[key], forKey: key)
            }
        }
        return managedObject
    }
}

// MARK: - Fetch methods. -
extension NSManagedObject {
    
    /// A method used to fetch the Entity Objects(Array) with help of predicate.
    /// - Parameter predicate: Pass the predicate, Make sure your predicate has valid argument.
    static func fetch(predicate: NSPredicate) -> [NSManagedObject]? {
        return fetch(predicate: predicate, sortDescriptor: nil)
    }
    
    /// A method used to fetch the Entity Objects(Array) with help of sortDescriptor.
    /// - Parameter sortDescriptor: Pass the array of sortDescriptor.
    static func fetch(sortDescriptor: [NSSortDescriptor]) -> [NSManagedObject]? {
        return fetch(predicate: nil, sortDescriptor: sortDescriptor)
    }
    
    /// /// A method used to fetch the Entity Objects(Array) with help of predicate and array of sortDescriptor.
    /// - Parameters:
    ///   - predicate: Pass the predicate, Make sure your predicate has valid argument.
    ///   - sortDescriptor: Pass the array of sortDescriptor.
    static func fetch(predicate: NSPredicate?, sortDescriptor: [NSSortDescriptor]?) -> [NSManagedObject]? {
        
        let fRequest = fetchRequest
        fRequest.predicate = predicate
        fRequest.sortDescriptors = sortDescriptor
        
        do { return try mainManagedObjectContext.fetch(fRequest) as? [NSManagedObject] }
            
        catch {
            AppLogs.debugPrint("Error while fetching the NSManagedObjects with predicate :- \(predicate ?? NSPredicate()), sortDescriptor :- \(sortDescriptor ?? [NSSortDescriptor()]) AND error is :- \(error.localizedDescription)")
        }
        return nil
    }
    
    /// Fetch all objects of Entity.
    static var allObjects: [Any]? {
        
        do { return try mainManagedObjectContext.fetch(fetchRequest)}
            
        catch {
            AppLogs.debugPrint("Error while fetching all NSManagedObjects from entity \(entityName) :- AND error is :- \(error.localizedDescription)")
        }
        return nil
    }
}

// MARK: - Update methods. -
extension NSManagedObject {
    
    /// A method is used to batch updates in Entity with help of dictionary and predicate.
    /// - Parameters:
    ///   - dict: Pass the dictionary with updated value, The changes you want to apply.
    ///   - predicate: Pass the predicate that contain the Entity infos(In which Entity actuall you want batch update), Make sure your predicate has valid argument.
    static func update(withDictionary dict: [String: Any], predicate: NSPredicate?) {
        
        let buRequest = batchUpdateRequest
        buRequest.propertiesToUpdate = dict
        buRequest.predicate = predicate
        buRequest.resultType = .updatedObjectIDsResultType
        
        let managedObjectContext = mainManagedObjectContext
        
        do {
            if let buResult = try managedObjectContext.execute(buRequest) as? NSBatchUpdateResult {
                if let managedObjectIDs = buResult.result as? [NSManagedObjectID] {
                    for id in managedObjectIDs {
                        let managedObject = managedObjectContext.object(with: id)
                        managedObjectContext.refresh(managedObject, mergeChanges: false)
                    }
                }
            }
            
        } catch {
            AppLogs.debugPrint("Error while updating the NSManagedObjects with dict :- \(dict), predicate :- \(predicate ?? NSPredicate()) AND error is :- \(error.localizedDescription)")
        }
    }
}

// MARK: - Delete methods. -
extension NSManagedObject {
    
    /// A non-static delete method used to delete the Entity object, you should have the object of Entity to used this method.
    func delete() {
        let managedObjectContext = NSManagedObject.mainManagedObjectContext
        managedObjectContext.delete(self)
    }
    
    /// A method used to delete the Entity object with help of predicate.
    /// - Parameter predicate: Pass the predicate, Make sure your predicate has valid argument.
    static func delete(predicate: NSPredicate) {
        
        let fRequest = fetchRequest
        fRequest.predicate = predicate
        
        let bdRequest = NSBatchDeleteRequest(fetchRequest: fRequest)
        bdRequest.resultType = .resultTypeCount
        
        let managedObjectContext = mainManagedObjectContext
        
        do {
            try managedObjectContext.execute(bdRequest)
            managedObjectContext.reset()
        }
        catch {
            AppLogs.debugPrint("Error while delete all NSManagedObjects with predicate :- \(predicate) AND error is :- \(error.localizedDescription)")
        }
    }
    
    /// A method is used to delete all the Entity objects.
    static func deleteAll() {
        
        let bdRequest = batchDeleteRequest
        bdRequest.resultType = .resultTypeCount
        
        let managedObjectContext = mainManagedObjectContext
        
        do {
            try managedObjectContext.execute(bdRequest)
            managedObjectContext.reset()
        }
        catch {
            AppLogs.debugPrint("Error while delete all NSManagedObjects AND error is :- \(error.localizedDescription)")
        }
    }
}

