//
//  ExtensionUIResponder.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Extension of UIResponder For getting the ParentViewController(UIViewController) of any UIView.
extension UIResponder {
    
    /// This Property is used to getting the ParentViewController(UIViewController) of any UIView.
    var viewController: UIViewController? {
        
        if self.next is UIViewController {
            return self.next as? UIViewController
        } else {

            guard let next = self.next else {
                return nil
            }
            
            return next.viewController
        }
    }
    
    var tblVCell: UITableViewCell? {
        
        if self.next is UITableViewCell {
            return self.next as? UITableViewCell
        } else {
            
            guard let next = self.next else {
                return nil
            }
            
            return next.tblVCell
        }
    }
    
    var collVCell: UICollectionViewCell? {
        
        if self.next is UICollectionViewCell {
            return self.next as? UICollectionViewCell
        } else {
            
            guard let next = self.next else {
                return nil
            }
            
            return next.collVCell
        }
    }
}
