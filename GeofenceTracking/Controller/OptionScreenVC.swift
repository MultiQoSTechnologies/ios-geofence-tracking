//
//  OptionScreenVC.swift
//  GeofenceTracking
//
//  Created by MQI-2 on 29/04/24.
//

import UIKit

class OptionScreenVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
    }
    
    //MARK: - Memory management methods -
    deinit {
        print("### deinit -> \(self.className)")
    }
    
}

//MARK: - initialization -
extension OptionScreenVC {
    func initialization() {
        
    }
}

//MARK: - Action Events -
extension OptionScreenVC {
    
    @IBAction private func map(sender: UIButton) {
        self.view.endEditing(true)
        DispatchQueue.main.async {
            
            GeofenceHelper.share.stratMonitoring()
            guard let map = self.storyboard?.instantiateViewController(identifier: "MapVC") as? MapVC else {
                return
            }
            
            self.navigationController?.pushViewController(map, animated: true)
        }
    }
    
    @IBAction private func withOutMap(sender: UIButton) {
        GeofenceHelper.share.stratMonitoring()
    }
}
