//
//  ApplicationMessages.swift
//
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation

class AppMessages {
    
    // MARK:- Common
    static var cAppName: String {
        return "Noble"
    }
    
    static var CCurrencySymbol: String {
        return "R"
    }
    
    // Alert Buttons.
    static var CYes: String {
        return "Yes"
    }
    
    static var CClear: String {
        return "Clear"
    }
    
    static var CCancel: String {
        return "Cancel"
    }
    
    static var CNoDataAvailable: String {
        return "No Data"
    }
    
    static var CGallery: String {
        return "Select from Gallery"
    }
    static var CCamera: String {
        return "Take from Camera"
    }
    static var CNotSupportCamera: String {
        return "Your device does not support camera"
    }
    
    static var CNo: String {
        return "No"
    }
    
    static var CJustNow: String {
        return "Just now"
    }
    
    //Validations
    static var CEmailBlank: String {
        return "Please enter your email address."
    }
    
    static var CEmailValid: String {
        return "Please enter valid email address."
    }
    
    static var CMobileNumberValid: String {
        return "Please enter valid mobile number."
    }
    
    static var CPasswordBlank: String {
        return "Please enter your password."
    }
    
    static var CPasswordValid: String {
        return "Password length must be at least 8 characters and must not contain spaces."
    }
    
    static var CCurrentPasswordBlank: String {
        return "Please enter current password."
    }
    
    static var CNewPasswordBlank: String {
        return "Please enter new password."
    }
    
    static var CConfirmPasswordBlank: String {
        return "Please enter confirm password."
    }
    
    static var CConfirmNotMatched: String {
        return "Password and confirm password does not match."
    }
    
    static var CFirstNameBlank: String {
        return "Please enter your first name."
    }
    
    static var CLastNameBlank: String {
        return "Please enter your last name."
    }
    
    static var CMobileNumberBlank: String {
        return "Please enter mobile number."
    }
    
    static var COTPBlank: String {
        return "Please enter valid OTP."
    }
    
    static var CEnterUserName: String {
        return "Please enter user name."
    }
    
    static var CEnterValidUserName: String {
        return "Please enter valid user name."
    }
    
    static var CSelectShoeSize: String {
        return "Please select shoe size UK."
    }
    
    static var CEnterBankName: String {
        return "Please enter bank name."
    }
    
    static var CEnterBranchCode: String {
        return "Please enter branch code."
    }
    
    static var CEnterAccountHolderName: String {
        return "Please enter account holder name."
    }
    
    static var CEnterAccountNumber: String {
        return "Please enter account number."
    }
    
    static var CEnterConfirmAccountNumber: String {
        return "Please enter confirm account number."
    }
    
    static var CDoesNotMatchAccountNumber: String {
        return "Confirm account number doesn't match with account number"
    }
    
    static var CPriceRangeValid: String {
        return "Please enter price range between"
    }
    
    static var CAcceptTermsAndCondition: String {
        return "You must agree with the Terms of service & Privacy Policies."
    }
    
    static var CSomethingWentWrong: String {
        return "Something went wrong"
    }
    
    static var CCameraNotAllow: String {
        return "Camera permission is denied. Please allow permission to camera for capturing photos using camera."
    }
    
    static var CGalleryNotAllow: String {
        return "Photos permission is denied. Please allow permission to gallery photos for selecting photos from gallery."
    }
    
    static var CTermsCondition: String {
        return "Terms of Services"
    }
    
    static var CTermsAndCondition: String {
        return "Terms & conditions"
    }
    
    static var CPrivacyPolicy: String {
        return "Privacy Policy"
    }
    
    static var CTermsConditionFullStr: String {
        return "By Creating the profile, you agree to Terms of Services and Privacy Policy of the Application."
    }
    
    static var CCreateProfile: String {
        return "Create Profile"
    }
    
    static var CCountry: String {
        return "Country"
    }
    
    static var CSortBy: String {
        return "Sort by"
    }
    
    static var CGender: String {
        return "Gender"
    }
    
    static var CState: String {
        return "State"
    }
    
    static var CCity: String {
        return "City"
    }
    
    static var CSelectSizeUK: String {
        return "Select size(UK)"
    }
    
    static var CSelectSizeType: String {
        return "Select size type"
    }
    
    static var CMale: String {
        return "Male"
    }
    
    static var CFemale: String {
        return "Female"
    }
    
    static var COther: String {
        return "Other"
    }
    
    static var CUploadProfilePicture: String {
        return "Upload Profile picture"
    }
    
    static var CSelectDob: String {
        return "Please select date of birth"
    }
    
    static var CSelectGender: String {
        return "Please select gender"
    }
    
    static var CSelectState: String {
        return "Please select state"
    }
    
    static var CSelectCity: String {
        return "Please select city"
    }
    
    static var CMostPopularProducts: String {
        return "Most Popular Products"
    }
    
    static var CAuctionProducts: String {
        return "Auction Products"
    }
    
    // MARK: - Navigation title
    static var CNavTitleTrendingProducts: String {
        return "Trending products"
    }
    
    static var CNavTitleNotifications: String {
        return "Notifications"
    }
    
    static var CNavTitleWishlist: String {
        return "Wishlist"
    }
    
    static var CNavTitleFilter: String {
        return "Filter"
    }
    
    static var CNavTitleProducts: String {
        return "Products"
    }
    
    static var CNavTitleBrand: String {
        return "Brands"
    }
    
    static var CBestMatch: String {
        return "Best Match"
    }
    
    static var CPriceLowToHigh: String {
        return "Price: Low to High"
    }
    
    static var CPriceHighToLow: String {
        return "Price: High to Low"
    }
    
    static var CMostPopular: String {
        return "Most popular"
    }
    
    static var CAlphabeticalAZ: String {
        return "Alphabetical (A-Z)"
    }
    
    static var CAlphabeticalZA: String {
        return "Alphabetical (Z-A)"
    }
    
    static var CNewlyListed: String {
        return "Newly Listed"
    }
    
    static var CEndingSoonest: String {
        return "Ending soonest"
    }
    
    static var CSearch: String {
        return "Search"
    }
    
    static var CVendorDetails: String {
        return "Vendor details"
    }
    
    static var CProductDetails: String {
        return "Product details"
    }
    
    static var CVendorReviews: String {
        return "Vendor reviews"
    }
    
    static var CUserReviews: String {
        return "User reviews"
    }
    
    static var CAddReview: String {
        return "Add review"
    }
    
    static var CViewReview: String {
        return "View reviews"
    }
    
    static var CProfile: String {
        return "Profile"
    }
    
    static var CMyOrders: String {
        return "My orders"
    }
    
    static var CMyOffers: String {
        return "My offers"
    }
    
    static var CMyBids: String {
        return "My bids"
    }
    
    static var CChangePassword: String {
        return "Change password"
    }
    
    static var CPushNotifications: String {
        return "Push notifications"
    }
    
    static var CMyAddresses: String {
        return "My addresses"
    }
    
    static var CPaymentOptions: String {
        return "Payment options"
    }
    
    static var CHelp: String {
        return "Help & support"
    }
    
    static var CLogout: String {
        return "Logout"
    }
    
    static var CNavTitleMakeAnOffer: String {
        return "Make an offer"
    }
    
    static var CDeleteAccount: String {
        return "Delete account"
    }
    
    static var CEditProfile: String {
        return "Edit profile"
    }
    
    static var CTrackOrder: String {
        return "Track order"
    }
    
    static var COrderDetails: String {
        return "Order details"
    }
    
    static var CMyCart: String {
        return "My cart"
    }
    
    static var CDoYouWantToLogoutYourAccount: String {
        return "Do you want to logout \nyour account?"
    }
    
    static var CDoYouWantToDeleteYourAccount: String {
        return "Do you want to delete \nyour account?"
    }
    
    static var CFrequentlyAskedQuestions: String {
        return "Frequently asked questions"
    }
    
    static var CContactUs: String {
        return "Contact us"
    }
    
    static var CPleaseEnterQuestion: String {
        return "Please enter the question."
    }
    
    static var CDateOfLastBid: String {
        return "Date of last bid"
    }
    
    static var CDateOfAuctionWon: String {
        return "Date of auction won"
    }
    
    static var CDateOfAuctionEnd: String {
        return "Date of auction end"
    }
    
    static var CBidDetail: String {
        return "Bid detail"
    }
    
    static var CBidWon: String {
        return "Bid won"
    }
    
    static var CBidLost: String {
        return "Bid lost"
    }
    
    static var CPleaseEnterBidAmount: String {
        return "Please enter bid amount"
    }
    
    static var CDoYouWantToDeleteAddress: String {
        return "Do you want to delete \naddress?"
    }
    
    static var CAddNewDetails: String {
        return "Add new details"
    }
    
    static var CEditDetails: String {
        return "Edit details"
    }
    
    static var CCheckout: String {
        return "Checkout"
    }
    
    static var CPleaseSelectAddress: String {
        return "Please select an address first."
    }
    
    static var CPleaseEnterAddress: String {
        return "Please enter address"
    }
    
    static var CPleaseEnterFlatNumber: String {
        return "Please enter flat/building number"
    }
    
    static var CPleaseEnterStreetNumber: String {
        return "Please enter street name"
    }
    
    static var CProductsManagement: String {
        return "Products management"
    }
    
    static var CInventoryManagement: String {
        return "Inventory management"
    }
    
    static var COrdersManagement: String {
        return "Orders management"
    }
    
    static var CBidsManagement: String {
        return "Bids management"
    }
    
    static var CStoreManagement: String {
        return "Store management"
    }
    
    static var CPaymentManagement: String {
        return "Payment management"
    }
    
    static var COfferedProducts: String {
        return "Offered products"
    }
    
    static var CViewOrder: String {
        return "View order"
    }
    
    static var CPleaseEnterStoreName: String {
        return "Please enter store name"
    }
    
    static var CPleaseEnterPostalCode: String {
        return "Please enter postal/zip code"
    }
    
    static var CPostalCodeValid: String {
        return "Please enter valid postal/zip code"
    }
    
    static var CAddNewProduct: String {
        return "Add new product"
    }
    
    static var CEditProduct: String {
        return "Edit product"
    }
    
    static var CEnterProductName: String {
        return "Please enter product name."
    }
    
    static var CEnterSku: String {
        return "Please enter sku."
    }
    
    static var CEnterColorway: String {
        return "Please enter colorway."
    }
    
    static var CSelectBrandName: String {
        return "Please select brand name."
    }
    
    static var CSelectGenderName: String {
        return "Please select gender."
    }
    
    static var CEnterProductShortDescription: String {
        return "Please enter product short description."
    }
    
    static var CSelectProductImages: String {
        return "Please select product images."
    }
    
    static var CDelivered: String {
        return "Delivered"
    }
    
    static var CCancelled: String {
        return "Cancelled"
    }
    
    static var COrderStatus: String {
        return "Order status"
    }
    
    static var COrderDelivered: String {
        return "Order delivered"
    }
    
    static var COrderCancelled: String {
        return "Order cancelled"
    }
    
    static var CReviews: String {
        return "Reviews"
    }
    
    static var CSellProduct: String {
        return "Sell product"
    }
    
    static var CPendingForApproval: String {
        return "Pending for approval"
    }
    
    static var CYourProductIsRejected: String {
        return "Your product is rejected"
    }
    
    static var CYourProductIsApproved: String {
        return "Your product is approved"
    }
    
    static var CAddVariants: String {
        return "Add variants"
    }
    
    static var CEditVariants: String {
        return "Edit variants"
    }
    
    static var CEdit: String {
        return "Edit"
    }
    
    static var CUploadProduct: String {
        return "Upload product"
    }
    
    static var CDoYouWantToUploadThisProduct: String {
        return "Do you want to upload \nthis product?"
    }
    
    static var CDeleteProduct: String {
        return "Delete product"
    }
    
    static var CDoYouWantToDeleteYourProduct: String {
        return "Do you want to delete \nyour product?"
    }
    
    static var CType: String {
        return "Type"
    }
    
    static var CSize: String {
        return "Size"
    }
    
    static var CEnterWayBillNo: String {
        return "Please enter way bill no"
    }
    
    static var CBidsDetails: String {
        return "Bids details"
    }
    
    static var CHighestBidAmount: String {
        return "Highest bid amount"
    }
    
    static var CMaxBid: String {
        return "Max bid"
    }
    
    static var CAuctionProduct: String {
        return "Auction product"
    }
    
    static var CSetBidIncrements: String {
        return "Set bid increments"
    }
    
    static var CDay: String {
        return "Day"
    }
    
    static var CHrs: String {
        return "Hrs."
    }
    
    static var CTime: String {
        return "Time"
    }
    
    static var CMin: String {
        return "Min."
    }
    
    static var CPleaseSelectSizeType: String {
        return "Please select size type"
    }
    
    static var CPleaseSelectSize: String {
        return "Please select size"
    }
    
    static var CPleaseEnterMinimumBidAmount: String {
        return "Please enter minimum bid amount"
    }
    
    static var CPleaseSelectBidIncrements: String {
        return "Please select bid increments"
    }
    
    static var CPleaseSelectDay: String {
        return "Please select day"
    }
    
    static var CPleaseSelectHrs: String {
        return "Please select time"
    }
    
    static var CPleaseSelectMin: String {
        return "Please select min"
    }
    
    static var CYourProductHasBeenAddedForAuction: String {
        return "Your product has been added for auction"
    }
    
    static var CAuctionedProducts: String {
        return "Auctioned products"
    }
    
    static var CLowStock: String {
        return "Low stock"
    }
    
    static var COutOfStock: String {
        return "Out of stock"
    }
    
    static var CDoYouWantToUpdatePaymentDetails: String {
        return "Do you want to update\npayment details?"
    }
    
    static var CDoYouWantToUpdateStoreDetails: String {
        return "Do you want to update\nstore details?"
    }
    
    static var CEditAccountDetails: String {
        return "Edit account details"
    }
    
    static var CEditStore: String {
        return "Edit store"
    }
    
    static var CEditPaymentDetails: String {
        return "Edit payment details"
    }
    
    static var CTotalSoldProducts: String {
        return "Total sold products"
    }
    
    static var COffersDetails: String {
        return "Offers details"
    }
    
    static var CAcceptOffer: String {
        return "Accept offer"
    }
    
    static var CDoYouWantToAcceptThisOffer: String {
        return "Do you want to accept \nthis offer?"
    }
    
    static var CDeclineOffer: String {
        return "Decline offer"
    }
    
    static var CDoYouWantToDeclineThisOffer: String{
        return "Do you want to decline \nthis offer?"
    }
    
    static var CCounterOffer: String {
        return "Counter offer"
    }
    
    static var CPleaseEnterCounterOffer: String {
        return "Please enter counter offer amount"
    }
    
    static var CAcceptedBy: String {
        return "Accepted by"
    }
    
    static var CAcceptedByMe: String {
        return "Accepted by me"
    }
    
    static var CExpired: String {
        return "Expired"
    }
    
    static var CRejected: String {
        return "Rejected"
    }
    
    static var COffersReceived: String {
        return "Offers received"
    }
    
    static var CYourOfferExpire: String {
        return "Your offer expires in:"
    }
    
    static var CYouHaveTimeToAccept: String {
        return "You have 24hrs to accept"
    }
    
    static var CCounterOfferAmount: String {
        return "Counter offer amount"
    }
    
    static var CLastOfferedAmount: String {
        return "Last offered amount"
    }
    
    static var CUpdateLogo: String {
        return "Update logo"
    }
    
    static var CEnterOfferAmt: String {
        return "Please enter offer amount"
    }
    
    static var CEnterQty: String {
        return "Please enter qty."
    }
    
    static var CEnterValidQty: String {
        return "Please enter valid qty."
    }
    
    static var CEnterSellingPrice: String {
        return "Please enter selling price"
    }
    
    static var CCurrentBidPrice: String {
        return "Current bid price"
    }
    
    static var CFrom: String {
        return "From"
    }
    
    static var CTotalProducts: String {
        return "Total products:"
    }
    
    static var CPrice: String {
        return "Price"
    }
    
    static var CPleaseSelectProfilePicture: String {
        return "Please select profile picture."
    }
    
    static var CResult: String {
        return "result"
    }
    
    static var CResults: String {
        return "results"
    }
    
    static var CShowing: String {
        return "Showing"
    }
    
    static var CPleaseSelectedDifferentSize: String {
        return "Please select different size."
    }
    
    static var CPositiveReviews: String {
        return "% Positive reviews"
    }
    
    static var CSelectVendors: String {
        return "Select vendors"
    }
    
    static var CSelectBrands: String {
        return "Select brands"
    }
    
    static var CHrsBid: String {
        return "Hrs"
    }
    
    static var CMinBid: String {
        return "Min"
    }
    
    static var CSecBid: String {
        return "Sec"
    }
    
    static var CDoYouWantToDeleteProductVariant: String {
        return "Do you want to delete \nproduct variant?"
    }
    
    static var CDoYouWantToDeleteCartItem: String {
        return "Do you want to delete \nyour cart item?"
    }
    
    static var CDeleteProductVariant: String {
        return "Delete product variant"
    }
    
    static var CDeleteYourCartItem: String {
        return "Delete your cart item"
    }
    
    static var CDeleteAuction: String {
        return "Delete auction"
    }
    static var CDoYouWantToDeleteYourAuction: String {
        return "Do you want to delete \nyour auction?"
    }
    
    static var COrderPlaced: String {
        return "Order placed:"
    }
    
    static var COrderDate: String {
        return "Order date:"
    }
    
    static var COrderCancelledBySeller: String {
        return "Order cancelled by the seller"
    }
    
    static var COrderReturnByUser: String {
        return "Order return by the user"
    }
    
    static var COrderCancelledByAdmin: String {
        return "Order cancelled by the admin"
    }
    
    static var CPending: String {
        return "Pending"
    }
    
    static var CDeliveredDate: String {
        return "Delivered date:"
    }
    
    static var CCartEmpty: String {
        return "There is nothing in your cart. let's add some items."
    }
    
    static var CSizeTitle: String {
        return "Size:"
    }
    
    static func CPleaseEnterValidBidAmount(value: String) -> String {
        return "Please enter bid amount according to margin set by the vendor like \(value) and so on."
    }
    
    static var CPleaseEnterValidOfferAmount: String {
        return "Offer amount should be greater than "
    }
    
    static var CViewAll: String {
        return "View all"
    }
    
    static var CMaximunSelection: String {
        return "Maximum selection is 5"
    }
    
    static var CAvailableQty: String {
        return "Available Qty."
    }
    
    static var CPriceFrom: String {
        return "Price(from)"
    }
    
    static var CSku: String {
        return "Sku"
    }
    
    static var CColorWay: String {
        return "Colorway"
    }
    
    static var CMakeAnOffer: String {
        return "Make an offer"
    }
    
    static var COfferLimitExceeded: String {
        return "Offer limit exceeded."
    }
    
    static var COtherReason: String {
        return "other"
    }
    
    static var CCancelOrderMessage: String {
        return "Are you sure you want to cancel this order?"
    }
    
    static var CCancelOrderTitle: String {
        return "Cancel order"
    }
    
    static var CVendor: String {
        return "vendor"
    }
    
    static var CUser: String {
        return "user"
    }
    
    static var CAdmin: String {
        return "admin"
    }
    
    static var COffer: String {
        return "offer"
    }
    
    static var COffers: String {
        return "offers"
    }
    
    static var CYouCanMakeAnotherOfferIn: String{
        return "You can make another offer in"
    }
    
    static var COfferExpiresIn: String {
        return "Offer expires in"
    }
    
    static var CMakeAnotherOffer: String {
        return "Make Another Offer"
    }
    
    static var CViewBidDetail: String {
        return "View detail"
    }
    
    static var CViewBids: String {
        return "View bids"
    }
    
    static var CIssueWith: String {
        return "Issue with"
    }
    
    static var CPleaseSelectIssueWith: String {
        return "Please select issue with"
    }
    
    static var CAskQuestion: String {
        return "Ask a question"
    }
    
    static var CDescription: String {
        return "Description"
    }
    
    static var CPleaseEnterDescription: String {
        return "Please enter description"
    }
    
    static var CClearAll: String {
        return "Clear all"
    }
    
    static var CClearNotifications: String {
        return "Clear notifications"
    }
    
    static var CDoYouWantToClearYourNotification: String {
        return "Do you want to clear your notifications?"
    }
    
    static var CMinAgo: String {
        return "1 minute ago"
    }
    static var CMinsAgo: String {
        return "minutes ago"
    }
    
    static var CSecsAgo: String {
        return "seconds ago"
    }
    
    static var CAnHourAgo: String {
        return "1 hour ago"
    }
    static var CHoursAgo: String {
        return "hours ago"
    }
    static var CDayAgo:   String {
        return "day ago"
    }
    
    static var CDaysAgo: String {
        return "days ago"
    }
    
    static var CYearsAgo: String {
        return "years ago"
    }
    
    static var CYearAgo: String {
        return "year ago"
    }
    
    static var CMonthAgo: String {
        return "month ago"
    }
    
    static var CMonthsAgo: String {
        return "months ago"
    }
    
    static var CApproved: String {
        return "Approved"
    }
    
    static var CRegisterAsSeller: String {
        return "Register as seller"
    }
    
    static var CAddStoreInformation: String {
        return "Add store information"
    }
    
    static var CPleaseUploadYourSelfie: String {
        return "Please upload your selfie."
    }
    
    static var CPleaseUploadFrontSideOfIDProof: String {
        return "Please upload front side of ID Proof."
    }
    
    static var CPleaseUploadBackSideOfIDProof: String {
        return "Please upload back side of ID Proof."
    }
    
    static var CRecentlyViewed: String {
        return "Recently viewed"
    }
    
    static var CTrending: String {
        return "Trending"
    }
    
    static var CReturnOrder: String {
        return "Return order"
    }
    
    static var CPromoCodeIsNotValid: String {
        return "This promo code is not valid"
    }
    
    static var CPromoCodeErrorMsg: String {
        return "The applied promo code is invalid. Kindly remove it to proceed."
    }
    
    static var CCopyWayBillNumber: String {
        return "Way Bill No. Copied to Clipboard"
    }
    
    static var CReceivedPayout: String {
        return "Received Payout"
    }
    
    static var CPendingPayout: String {
        return "Pending Payout"
    }
    
    static var CMonth: String {
        return "Month"
    }
    
    static var CYear: String {
        return "Year"
    }
    
    static var COrderPayout: String {
        return "Order payout"
    }
}
