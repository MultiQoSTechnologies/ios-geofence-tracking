//
//  NoInternetConnectionView.swift
//  Link4Prof
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import UIKit

class NoInternetConnectionView: UIView {
    
    static let sharedNoInternetMode: NoInternetConnectionView = {
        
        let view = NoInternetConnectionView()
        let noInternetView = view.setUpNoInternetView()
        return noInternetView
    }()
    
    var blockForRemove: (() -> (Void))?
    
    @IBOutlet weak var lblNoInternet: UILabel!
    @IBOutlet weak var btnTryAgain: UIButton!
    @IBOutlet weak var lblNoConnection: UILabel!
    
    func setUpNoInternetView() -> NoInternetConnectionView {
        
        let noInternetView: NoInternetConnectionView = .initFromNib()
        return noInternetView
    }
    
}

//MARK:- General Methods
//MARK:-
extension NoInternetConnectionView {
    
    func show() {
        
//        self.frame = CGRect(x: 0.0, y: 0.0, width: CScreenWidth, height: CScreenHeight)
//        appDelegate.window?.addSubview(self)
        
        self.lblNoInternet.text = "CNoInternetConn" == "" ? "Check your wifi or mobile data connection" : "CNoInternetConn"
        self.lblNoConnection.text = "CNoConnection" == "" ? "No Connection" : "CNoConnection"
        self.btnTryAgain.setTitle("CTryAgain" == "" ? "Try Again" : "CTryAgain", for: .normal)
    }
}

//MARK:- Action Events
//MARK:-
extension NoInternetConnectionView {
    
    @IBAction func btnTryAgainClicked(_ sender: UIButton) {
        
        //self.removeFromSuperview()
        //self.blockForRemove?()
    }
}
