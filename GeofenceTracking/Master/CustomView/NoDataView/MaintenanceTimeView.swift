//
//  MaintenanceTimeView.swift
//  Link4Prof
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import UIKit


class MaintenanceTimeView: UIView {
    
    var blockForRemove: (() -> (Void))?
    
    static let sharedMaintenanceMode: MaintenanceTimeView = {
        let view = MaintenanceTimeView()
        let maintenanceView = view.setUpMaintenanceView()
        return maintenanceView
    }()
    
    @IBOutlet weak var lblInMaintenance: UILabel!
}

//MARK:- General Methods
//MARK:-
extension MaintenanceTimeView {
    
    func setUpMaintenanceView() -> MaintenanceTimeView {
        let maintenanceView: MaintenanceTimeView = .initFromNib()
        return maintenanceView
    }
    
    func show() {
        guard let window: UIWindow = UIApplication.shared.windows.first else {
            return
        }
        self.frame = CGRect(x: 0.0, y: 0.0, width: UIDevice.screenWidth, height: UIDevice.screenHeight)
        window.addSubview(self)
        self.lblInMaintenance.text = "Maintenance Msg"
        self.lblInMaintenance.textColor = #colorLiteral(red: 0.9333333333, green: 0.1960784314, blue: 0.2431372549, alpha: 1)
    }
}


extension UIView {
    class func initFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
}
