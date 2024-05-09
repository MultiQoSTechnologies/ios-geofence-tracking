//
//  ExtensionUICollectionView.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func enableNoDataView(message: String) {
        
        if let noDataView = NoDataView.viewFromXib as? NoDataView {
            
            noDataView.frame = self.frame
            noDataView.lblMessage.text = message
            
            self.backgroundView = noDataView
        }
    }
    
    func disableNoDataView() {
        
        if self.backgroundView != nil {
            self.backgroundView = nil
        }
    }
    
    var dummyCell: UICollectionViewCell {
        let defaultCell = UICollectionViewCell(frame: .zero)
        return defaultCell
    }
    
    var lastIndexPath: IndexPath? {
        let sections = self.numberOfSections
        
        if (sections<=0){
            return nil
        }
        
        let rows = self.numberOfItems(inSection: sections-1)
        
        if (rows<=0){return nil}
        
        return IndexPath(item: rows-1, section: sections-1)
    }
}

