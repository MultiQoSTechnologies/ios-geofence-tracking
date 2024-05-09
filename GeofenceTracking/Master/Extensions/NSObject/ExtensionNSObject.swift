//
//  ExtensionNSObject.swift
//

import Foundation

class MultiCastDelegate: NSObject
{
    var _delegates = NSMutableArray()
    
    func add(delegate:AnyObject) -> Void
    {
        if (!_delegates.contains(delegate)) {
            _delegates.add(delegate)
        }
    }
    
    func remove(delegate:AnyObject) -> Void
    {
        if (_delegates.contains(delegate)) {
            _delegates.remove(delegate)
        }
    }
    
    override func responds(to aSelector: Selector) -> Bool
    {
        if (super.responds(to: aSelector)) {
            return true
        }
        
        for delegate in _delegates
        {
            if ((delegate as AnyObject).responds(to: aSelector)) {
                return true
            }
        }
        
        return false
    }
    
//        override func methodSignatureForSelector(aSelector: Selector) -> NSMethodSignature! {
//            _delegates.enumerateObjectsUsingBlock { (delegate, index, finish) in
//                if (delegate.respondsToSelector(aSelector)) {
//                    return delegate.methodForSelector(aSelector)
//                }
//            }
//        }
}


extension NSObject{
    // MARK:
    // MARK:- Property
    
    func isNull() -> Bool
    {
        if (self.isEqual(NSNull()) || self is NSNull) {
            return true
        }
        
        if (self is String) {
            if ((self as! String).count == 0) {
                return true
            }
        }
        
        if (self is NSArray) {
            if ((self as! NSArray).count == 0) {
                return true
            }
        }
        
        if (self is NSDictionary) {
            if ((self as! NSDictionary).count == 0) {
                return true
            }
        }
        
        return false
    }
    
    
    
    
    /**
        Method from NSObject Extension
     */
    
    func set(object anObj:AnyObject?, forKey:UnsafeRawPointer) -> Void
    {
        objc_setAssociatedObject(self, forKey, anObj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    
    /**
        Method from NSObject Extension
     */
    
    func object(forKey key:UnsafeRawPointer) -> AnyObject?
    {
        return objc_getAssociatedObject(self, key) as AnyObject
    }
    
    
    
    
    
    // (Int)integer
    
    func set(Int integerValue:Int, key:UnsafeRawPointer) -> Void
    {
        self.set(object: NSNumber(value: integerValue as Int), forKey: key)
    }
    
    func int(forKey key:String) -> Int
    {
        return self.object(forKey: key)!.intValue
    }
    
    
    
    
    
    // (float)floatValue
    
    func set(Float floatValue:Float, key:UnsafeRawPointer) -> Void
    {
        self.set(object: NSNumber(value: floatValue as Float), forKey: key)
    }
    
    func float(forKey key:String) -> Float
    {
        return self.object(forKey: key)!.floatValue
    }
    
    
    
    
    
    // (double)doubleValue
    
    func set(Double doubleValue:Double, key:UnsafeRawPointer) -> Void
    {
        self.set(object: NSNumber(value: doubleValue as Double), forKey: key)
    }
    
    func double(forKey key:String) -> Double
    {
        return self.object(forKey: key)!.doubleValue
    }
    
    
    
    
    
    // (BOOL)boolean
    
    func set(Bool boolValue:Bool, key:UnsafeRawPointer) -> Void
    {
        self.set(object: NSNumber(value: boolValue as Bool), forKey: key)
    }
    
    func bool(forKey key:String) -> Bool
    {
        return self.object(forKey: key)!.boolValue
    }
    
    
    
    // MARK:
    // MARK:- Perform Block
    
    func performBlock(block: @escaping (()->Void)) -> Void
    {
        CGCDMainThread.async {
            block()
        }
    }
    
    func performBlockOnMainThread(block:@escaping (()->Void)) -> Void
    {
        CGCDMainThread.async {
            block()
        }
    }
    
    func performBlockOnMainThread(block:@escaping (()->Void), afterDelay:UInt64) -> Void
    {
        CGCDMainThread.asyncAfter(deadline: DispatchTime.now() + Double(Int64(afterDelay * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
            block()
        })
    }
    
    func performBlockOnBackgroundThread(block:@escaping (()->Void), afterDelay:UInt64) -> Void
    {
        CGCDBackgroundThread.asyncAfter(deadline: DispatchTime.now() + Double(Int64(afterDelay * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
            block()
        })
    }
    
    func performBlockWithHighPriority(block:@escaping (()->Void)) -> Void
    {
        CGCDBackgroundThread.async {
            block()
        }
    }
    
    func performBlockWithLowPriority(block:@escaping (()->Void)) -> Void
    {
        CGCDBackgroundThread.async {
            block()
        }
    }
}

// MARK: - Document Directory -
extension FileManager {
    
    static func applicationDocumentsDirectory() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let basePath = paths.count > 0 ? paths[0] : nil;
        return basePath;
    }
    
    static func checkfileExistInDocumentDirectory(_ filePath: String?) -> Bool {
        let fileManager = FileManager()
        return fileManager.fileExists(atPath: filePath!)
    }
    
    static func removeFileAtPathFromDocumentDirectory(_ outputPath : String?) {
        let fileManager = FileManager()
        
        if (fileManager.fileExists(atPath: outputPath!)) {
            
            if (fileManager.isDeletableFile(atPath: outputPath!)) {
                do {
                    try fileManager.removeItem(atPath: outputPath!)
                }
                    
                catch let error as NSError {
                    AppLogs.debugPrint("Ooops! Something went wrong: \(error)")
                }
                
            }
        }
    }
}
