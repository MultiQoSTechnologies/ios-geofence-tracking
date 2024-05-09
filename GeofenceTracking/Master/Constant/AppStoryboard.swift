
import Foundation
import UIKit

enum AppStoryboard<T: UIViewController> : String {
    
    case main = "Main"
    case profile = "Profile"
    case home = "Home"
    case search = "Search"
    case cart = "Cart"
    case product = "Product"
    case filter = "Filter"
    case vendor = "Vendor"
    case tabbar = "Tabbar"
    case offer = "Offer"
    case order = "Order"
    case seller = "Seller"
    case help = "Help"
    case bid = "Bid"
    case address = "Address"
    case sellerProduct = "SellerProduct"
    case sellerOrder = "SellerOrder"
    case sellerBid = "SellerBid"
    case sellerStore = "SellerStore"
    case sellerSoldProduct = "SellerSoldProduct"
    case sellerOffer = "SellerOffer"
    case sellerNotification = "SellerNotification"
    case sellerInventory = "SellerInventory"
    case sellerPayment = "SellerPayment"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController(viewControllerClass: T.Type) -> T? {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        if #available(iOS 13.0, *) {
            if let controller = instance.instantiateViewController(identifier: storyboardID) as? T {
                return controller
            }
        } else {
            if let controller = instance.instantiateViewController(withIdentifier: storyboardID) as? T {
                return controller
            }
        }
        return nil
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

