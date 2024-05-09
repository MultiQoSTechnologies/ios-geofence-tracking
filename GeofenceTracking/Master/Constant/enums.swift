//
//  enums.swift
//  mrsnark
//
//  Created by MultiQoS-Flutter1 on 14/07/21.
//

import Foundation

enum BottomTabBarType: Int {
    case home = 0
    case search = 1
    case cart = 2
    case profile = 3
    case sellNow = 4
}

enum DropDownType {
    case normalSelection
    case optionWithImage
}

enum WebViewType: String {
    case terms = "terms-and-conditions"
    case privacy = "privacy-policy"
}

enum NavigationBarTypes {
    case home
    case product
    case filter
    case productDetail
    case review
    case reviewFilter
    case seller
    case productManagement
    case inventoryManagement
}

enum HomeCategoryType: Codable {
    case banner
    case recentView
    case chooseBrand
    case mostPopular
    case auction
    case homeAdv
    case trendingProduct
}

enum ProductType: String {
    case trending = "trending"
    case mostPopular = "popular"
    case auction = "auction"
    case wishList = "wishlist"
    case product = "product"
    case productVendor = "product vendor"
    case brand = "brand"
    case trendingProducts = "trending_products"
}

enum FilterType: String {
    case type = "Type"
    case categories = "Categories"
    case brands = "Brands"
    case vendors = "Vendors"
    case colors = "Colors"
    case gender = "Gender"
    case priceRange = "Price range"
    case size = "Size Cell"
    case sizeType = "Size type"
    case sizeNo = "Size"
    case auctioned = "Auctioned"
    case unAuctioned = "Un-auctioned"
    case all = "All"
    case qty = "Qty."
}

enum ProfileOptionType: String {
    case profile
    case myOrder
    case myOffer
    case myBid
    case changePassword
    case pushNotification
    case myAddress
    case payment
    case help
    case logout
    case deleteAccount
    case frequently
    case contactUs
    case privacyPolicy
    case termsOfService
}

enum OfferStatus: String {
    case initial = "Initial"    /// Initial state of the offer
    case buyerOffered = "buyerOffered"  /// When buyer offer to the vendor
    case vendorOffered = "vendorOffered" /// When vendor offer to the buyer
    case accepted = "Offer accepted"  /// When vendor accept the offer
    case rejected = "Offer rejected"  /// When vendor Reject the offer
    case pending = "Offer pending"    /// Waiting for vendor to take an action on offer
    case expired = "Offer expired"    /// When offer expired (No action take from vendor)
}

enum OfferAPIStatus: String {
    case initial = ""
    case buyerOffered = "buyerOffered"
    case vendorOffered = "counter"
    case accepted = "accept"
    case rejected = "reject"
    case pending = "pending"
    case expired = "expired"
}

enum OrderType: String {
    case onGoing = "onGoing"
    case completed = "completed"
    case cancelled = "cancelled"
}

enum OfferType: String {
    case onGoing = "ongoing"
    case accepted = "accept"
    case cancelled = "cancel"
}

enum BidType: String {
    case onGoing = "ongoing"
    case won = "won"
    case lost = "lost"
}

enum BrandType {
    case home
    case seeAll
}

enum sellerOverviewType {
    case productsManagement
    case inventoryManagement
    case ordersManagement
    case bidsManagement
    case storeManagement
    case paymentManagement
    case offeredProducts
    case received
    case pending
    case nextPaymentDate
}

enum PayoutType: String {
    case pending
    case deposited
    case view
}

enum DueType: String {
    case past = "past"
    case current = "current"
    case none = ""
}

enum OrderStatusTitleType: String {
    case placed = "Order placed"
    case shippedToAuthenticator = "Order shipped to authenticator"
    case beingInspected = "Your item is being inspected"
    case authenticated = "Order authenticated"
    case shipped = "Order shipped"
    case received = "Order received"
}

enum OrderStatusType: String {
    case placed = "placed"
    case shippedToAuthenticator = "authenticator"
    case beingInspected = "inspected"
    case authenticated = "authenticated"
    case shipped = "shipped"
    case received = "received"
    case rejected = "rejected"
    case returnInitiate = "return_initiate_started"
    case returnCompleted = "return_initiate_completed"
}

enum HomeBannerTag: String {
    case brand = "brand"
    case product = "product"
    case none = "none"
}

enum ProductManagementStatusType: String {
    case pending = "pending"
    case rejected = "rejected"
    case approved = "approved"
    case auction = "active"
}

enum SellerBidType: String {
    case upcoming = "pending"
    case onGoing = "ongoing"
    case completed = "completed"
}

enum VariantType: String {
    case lowStock = "Low stock"
    case outStock = "Out of stock"
}

enum StoreOptionType: String {
    case profile = "profile"
    case totalProduct = "Total products"
    case auctionedProducts = "Auctioned products"
    case totalOrders = "Total orders"
    case totalSoldProducts = "Total sold products"
    case frequentlyAskedQuestions = "Frequently asked questions"
    case contactUs = "Contact us"
    case privacyPolicy = "Privacy policy"
    case termsOfServices = "Terms of services"
}

enum VariantErrorType {
    case type
    case size
    case qty
    case price
}

enum AddressType {
    case add
    case edit
    case checkOut
}

enum AddressAction {
    case delete
    case edit
}

enum CartItemType: String {
    case auction = "auction"
    case offer = "offer"
}

enum ReviewType {
    case viewAllReview
    case addReview
}
 
enum CMSType: String {
    case user
    case vendor
}

enum OperationalKeys: String {
    case userId = "userId"
}

enum ImageType {
    case url
    case assets
}

enum AuctionStatusType: String {
    case initial = ""
    case pending = "pending"
    case ongoing = "ongoing"
    case complete = "completed"
}

enum IssueWithType: String {
    case orderRelated  = "order_related"
    case queryRelated = "query_related"
}

enum NotificationType: String {
    case productAccept = "product_accept"
    case productReject = "product_reject"
    case orderTracking = "order_tracking"
    case auctionStart = "auction_start"
    case auctionClosed = "auction_closed"
    case bidPlace = "bid_place"
    case userOfferAccept = "user_offer_accept"
    case userOfferMade = "user_offer_made"
    case orderPlace = "order_place"
    case sellerOfferAccept = "seller_offer_accept"
    case sellerOfferReject = "seller_offer_reject"
    case sellerOfferCounter = "seller_offer_counter"
    case wonBid = "won_bid"
    case auctionCloseSoon = "auction_close_soon"
    case cartCloseSoon = "cart_close_soon"
    case bidOvertaken = "bid_overtaken"
    case lostBid = "lost_bid"
    case orderTrackingVendor = "order_tracking_vendor"
    case buyerReturnOrder = "buyer_return_order"
    case buyerConfirmOrder = "buyer_confirm_order"
    case sellerReturnOrder = "seller_return_order"
    case inventoryStock = "inventory_stock"
}

enum VerifyVendorStatusType: String {
    case pending = "pending"
    case rejected = "rejected"
    case approved = "approved"
    case initial = "initial"
}
