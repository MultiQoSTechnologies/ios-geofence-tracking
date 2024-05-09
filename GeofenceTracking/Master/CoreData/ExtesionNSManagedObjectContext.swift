//
//  ExtesionNSManagedObjectContext.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    // MARK: -
    // MARK: -
    
    /// A method is used to save coredata related changes on disk, Please don't access this method directly, Though you can use below syntax =
    /// CoreDataManager.shared.save().
    func saveChanges() {
        
        if self.hasChanges {
            do { try save() }
            catch {
                AppLogs.debugPrint("Error while saving the single change into mainManagedObjectContext :- \(error.localizedDescription)")
            }
        }
    }
    
    
    /// A method is used to save coredata related changes on disk with Multiple MOC, Please don't access this method directly, Though you can use below syntax =
    /// CoreDataManager.shared.saveChangesOnMultipleMOC().
   static func saveChangesOnMultipleMOC(withManagedObjectContext childManagedObjectContext: NSManagedObjectContext, mediatorMangedObjectContext: NSManagedObjectContext, privateManagedObjectContext: NSManagedObjectContext) {
        
    saveChangesOnChildContext(withManagedObjectContext: childManagedObjectContext, mediatorMangedObjectContext: mediatorMangedObjectContext, privateManagedObjectContext: privateManagedObjectContext)
    }
    
    /// A private method.
    private static func saveChangesOnChildContext(withManagedObjectContext childManagedObjectContext: NSManagedObjectContext, mediatorMangedObjectContext: NSManagedObjectContext, privateManagedObjectContext: NSManagedObjectContext) {
        
        if childManagedObjectContext.hasChanges {
            do {
                try childManagedObjectContext.save()
                self.saveChangesOnMediatorContext(withManagedObjectContext: mediatorMangedObjectContext, privateManagedObjectContext: privateManagedObjectContext)
            }
            catch {
                AppLogs.debugPrint("Error while saving the changes into childNSManagedObjectContext AND Error is :- \(error.localizedDescription)")
            }
        }
    }
    
    /// A private method.
    private static func saveChangesOnMediatorContext(withManagedObjectContext mediatorMangedObjectContext: NSManagedObjectContext, privateManagedObjectContext: NSManagedObjectContext) {
        
        mediatorMangedObjectContext.perform {
            if mediatorMangedObjectContext.hasChanges {
                do {
                    try mediatorMangedObjectContext.save()
                    self.saveChangesOnPrivateContext(withManagedObjectContext: privateManagedObjectContext)
                }
                catch {
                    AppLogs.debugPrint("Error while saving the changes into mediatorNSManagedObjectContext AND Error is :- \(error.localizedDescription)")
                }
            }
        }
    }
    
    /// A private method.
    private static func saveChangesOnPrivateContext(withManagedObjectContext privateManagedObjectContext: NSManagedObjectContext) {
        
        privateManagedObjectContext.performAndWait {
            if privateManagedObjectContext.hasChanges {
                do {
                    try privateManagedObjectContext.save()
                }
                catch {
                    AppLogs.debugPrint("Error while saving the changes into privateNSManagedObjectContext AND Error is :- \(error.localizedDescription)")
                }
            }
        }
    }
}
