//
//  ColorPickerManager.swift
//  avellp
//
//  Created by MQI-2 on 13/06/23.
//

import UIKit

fileprivate var topMostViewController : UIViewController? {
    return UIApplication.shared.topMostVC()
}

final class ColorPickerManager: NSObject {
    
    /// Shared(Singleton) object of ColorPickerManager class.
    static let shared: ColorPickerManager = ColorPickerManager()
    
    private(set) lazy var colorPickerViewController: UIColorPickerViewController = {
        let colorPickerViewController = UIColorPickerViewController()
        colorPickerViewController.delegate = self
        return colorPickerViewController
    }()
    
    private(set) var commpletion: ((_ color: UIColor?) -> ())?

}

extension ColorPickerManager {
    
    func presentColorPickerManager(commpletion: ((_ color: UIColor?) -> ())?) {
        
        self.commpletion = commpletion
        topMostViewController?.present(colorPickerViewController, animated: true, completion: nil)
    }
}


extension ColorPickerManager: UIColorPickerViewControllerDelegate {
    
    //  Called once you have finished picking the color.
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        guard let commpletion = self.commpletion else {
            return
        }
        commpletion(viewController.selectedColor)
        
    }
    
    //  Called on every color selection done in the picker.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        
    }
}
