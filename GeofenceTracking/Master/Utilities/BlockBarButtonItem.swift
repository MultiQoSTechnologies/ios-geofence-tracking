//
//  BlockBarButtonItem.swift
// 
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

/**
 `Example`
 ```
 let searchBarItem = BlockBarButtonItem(image: UIImage(named: <#Image Name#>), style: .plain) { [weak self] (_) in
     guard let self = self else { return }
     // TODO :
 }
 self.navigationItem.rightBarButtonItem = searchBarItem
 
 ```
 */

class BlockBarButtonItem: UIBarButtonItem {
    
    private var actionHandler: ((UIBarButtonItem?) -> Void)? = nil
    
    convenience init(title: String?, style: UIBarButtonItem.Style, actionHandler: ((UIBarButtonItem?) -> Void)?) {
        self.init(title: title, style: style, target: nil, action: #selector(barButtonItemPressed))
        self.target = self
        self.actionHandler = actionHandler
    }
    
    convenience init(image: UIImage?, style: UIBarButtonItem.Style, actionHandler: ((UIBarButtonItem?) -> Void)?) {
        self.init(image: image, style: style, target: nil, action: #selector(barButtonItemPressed))
        self.target = self
        self.actionHandler = actionHandler
    }
    
    @objc func barButtonItemPressed(sender: UIBarButtonItem) {
        actionHandler?(sender)
    }
}
