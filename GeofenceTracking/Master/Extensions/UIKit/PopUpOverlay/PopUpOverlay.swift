//
//  PopUpOverlay.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import UIKit

class PopUpOverlay: UIView {
    
    var shouldOutSideClick: Bool = false
    var type: PopUpPresentType = .none
    
    @IBOutlet weak var imgVBlur: UIImageView!
    
    static var shared: PopUpOverlay? {
        guard let popUpOverlay = PopUpOverlay.viewFromXib as? PopUpOverlay else { return nil}
        popUpOverlay.frame = UIDevice.mainScreen.bounds
        return popUpOverlay
    }
}

extension PopUpOverlay {
    
    enum PopUpPresentType {
        case none
        case center
        case bottom
        case topToCenter
        case bottomToCenter
        case leftToCenter
        case rightToCenter
    }
}

extension PopUpOverlay {
    
    @IBAction private func btnCloseTapped(sender: UIButton) {
        if shouldOutSideClick {
            if let popUpOverlaySubView = self.subviews.last {
                self.dismissPopUpOverlayView(view: popUpOverlaySubView, completionHandler: nil)
            }
        }
    }
}

extension PopUpOverlay {
    
    func presentPopUpOverlayView(view: UIView, completionHandler: popUpCompletionHandler?) {
        
        switch type {
        case .none:
            if let completionHandler = completionHandler {
                completionHandler()
            }
        case .center:
            view.center = UIDevice.screenCenter
            view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            
            UIView.animate(withDuration: 0.3, animations: {
                view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { (completed) in
                if completed {
                    if let completionHandler = completionHandler {
                        completionHandler()
                    }
                }
            })
        case .bottom:
            view.CViewSetWidth(width: UIDevice.screenWidth)
            view.CViewSetY(y: UIDevice.screenHeight - (UIDevice.isIPhoneXSeries ? (34.0 + 49.0) : 49.0))
            
            UIView.animate(withDuration: 0.2, animations: {
                view.CViewSetY(y: UIDevice.screenHeight - (UIDevice.isIPhoneXSeries ? (34.0 + 49.0) : 49.0) - view.CViewHeight)
            }, completion: { (completed) in
                if completed {
                    UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.05, options: .curveEaseIn, animations: {
                        view.transform = CGAffineTransform(translationX: 0.0, y: 3.0)
                    }, completion: { (completed) in
                        if completed {
                            view.transform = .identity
                            if let completionHandler = completionHandler {
                                completionHandler()
                            }
                        }
                    })
                }
            })
        case .topToCenter:
            view.CViewSetCenterX(x: UIDevice.screenCenterX)
            view.CViewSetCenterY(y: 0.0)
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .layoutSubviews, animations: {
                view.CViewSetCenterY(y: UIDevice.screenCenterY)
            }, completion: { (completed) in
                if completed {
                    if let completionHandler = completionHandler {
                        completionHandler()
                    }
                }
            })
        case .bottomToCenter:
            view.CViewSetCenterX(x: UIDevice.screenCenterX)
            view.CViewSetCenterY(y: UIDevice.screenHeight - (UIDevice.isIPhoneXSeries ? (34.0 + 49.0) : 49.0))
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .layoutSubviews, animations: {
                view.CViewSetCenterY(y: UIDevice.screenCenterY)
            }, completion: { (completed) in
                if completed {
                    if let completionHandler = completionHandler {
                        completionHandler()
                    }
                }
            })
        case .leftToCenter:
            view.CViewSetCenterY(y: UIDevice.screenCenterY)
            view.CViewSetCenterX(x: 0.0)
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .layoutSubviews, animations: {
                view.CViewSetCenterX(x: UIDevice.screenCenterX)
            }, completion: { (completed) in
                if completed {
                    if let completionHandler = completionHandler {
                        completionHandler()
                    }
                }
            })
        case .rightToCenter:
            view.CViewSetCenterY(y: UIDevice.screenCenterY)
            view.CViewSetCenterX(x: UIDevice.screenWidth)
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .layoutSubviews, animations: {
                view.CViewSetCenterX(x: UIDevice.screenCenterX)
            }, completion: { (completed) in
                if completed {
                    if let completionHandler = completionHandler {
                        completionHandler()
                    }
                }
            })
        }
    }
    
    func dismissPopUpOverlayView(view: UIView, completionHandler: popUpCompletionHandler?) {
        
        switch type {
        case .none:
            view.removeFromSuperview()
            imgVBlur.image = nil
            self.removeFromSuperview()
            
            if let completionHandler = completionHandler {
                completionHandler()
            }
        case .center:
            UIView.animate(withDuration: 0.3, animations: {
                view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }, completion: { (completed) in
                if completed {
                    view.removeFromSuperview()
                    self.imgVBlur.image = nil
                    self.removeFromSuperview()
                    
                    if let completionHandler = completionHandler {
                        completionHandler()
                    }
                }
            })
        case .bottom:
            UIView.animate(withDuration: 0.3, animations: {
                view.CViewSetY(y: UIDevice.screenHeight - (UIDevice.isIPhoneXSeries ? (34.0 + 49.0) : 49.0))
            }, completion: { (completed) in
                if completed {
                    view.removeFromSuperview()
                    self.imgVBlur.image = nil
                    self.removeFromSuperview()
                    
                    if let completionHandler = completionHandler {
                        completionHandler()
                    }
                }
            })
        case .topToCenter:
            UIView.animate(withDuration: 0.20, animations: {
                view.CViewSetY(y: 0.0)
            }, completion: { (completed) in
                if completed {
                    UIView.animate(withDuration: 0.10, delay: 0.0, options: .layoutSubviews, animations: {
                        view.CViewSetHeight(height: 0.0)
                    }, completion: { (completed) in
                        if completed {
                            view.removeFromSuperview()
                            self.imgVBlur.image = nil
                            self.removeFromSuperview()
                            
                            if let completionHandler = completionHandler {
                                completionHandler()
                            }
                        }
                    })
                }
            })
        case .bottomToCenter:
            UIView.animate(withDuration: 0.3, animations: {
                view.CViewSetY(y: UIDevice.screenHeight - (UIDevice.isIPhoneXSeries ? (34.0 + 49.0) : 49.0))
            }, completion: { (completed) in
                if completed {
                    view.removeFromSuperview()
                    self.imgVBlur.image = nil
                    self.removeFromSuperview()
                    
                    if let completionHandler = completionHandler {
                        completionHandler()
                    }
                }
            })
        case .leftToCenter:
            UIView.animate(withDuration: 0.05, animations: {
                view.CViewSetX(x: 0.0)
            }, completion: { (completed) in
                if completed {
                    UIView.animate(withDuration: 0.25, delay: 0.0, options: .layoutSubviews, animations: {
                        view.CViewSetWidth(width: 0.0)
                    }, completion: { (completed) in
                        if completed {
                            view.removeFromSuperview()
                            self.imgVBlur.image = nil
                            self.removeFromSuperview()
                            
                            if let completionHandler = completionHandler {
                                completionHandler()
                            }
                        }
                    })
                }
            })
        case .rightToCenter:
            UIView.animate(withDuration: 0.3, animations: {
                view.CViewSetX(x: UIDevice.screenWidth)
            }, completion: { (completed) in
                if completed {
                    view.removeFromSuperview()
                    self.imgVBlur.image = nil
                    self.removeFromSuperview()
                    
                    if let completionHandler = completionHandler {
                        completionHandler()
                    }
                }
            })
        }
    }
}
