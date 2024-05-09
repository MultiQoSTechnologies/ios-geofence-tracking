//
//  MediaManager.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit
import Photos

fileprivate var topMostViewController : UIViewController? {
    return UIApplication.shared.topMostVC()
}

final class MediaManager: NSObject {
    
    /// Shared(Singleton) object of MediaManager class.
    static let shared: MediaManager = MediaManager()
    
    private(set) lazy var imagePickerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        return imagePickerController
    }()
    
    private(set) var commpletion: ((_ image: UIImage?, _ info: [UIImagePickerController.InfoKey : Any]?) -> ())?
    
}

extension MediaManager {
    
    var allowsEditing: Bool {
        get {
            return imagePickerController.allowsEditing
        } set {
            imagePickerController.allowsEditing = newValue
        }
    }
    
    enum MediaSourceType: Equatable {
        
        case photoLibrary(String)
        case camera(String)
        case savedPhotosAlbum(String)
        
        fileprivate var strValue: String {
            
            switch self {
            
            case .photoLibrary(let strPhotoLibrary):
                return strPhotoLibrary
                
            case .camera(let strCamera):
                return strCamera
                
            case .savedPhotosAlbum(let strSavedPhotosAlbum):
                return strSavedPhotosAlbum
            }
        }
        
        fileprivate func takeAppropriateAction(mediaManager: MediaManager) {
            
            switch self {
            
            case .camera:
                mediaManager.takeAPhoto(cameraType: .rear)
                
            case .photoLibrary:
                mediaManager.chooseFromPhotoLibrary()
                
            case .savedPhotosAlbum:
                mediaManager.chooseFromSavedPhotosAlbum()
            }
        }
    }
}

extension MediaManager {
    
    func presentImagePickerController(isEditing: Bool = false, title: String? = nil, message: String? = nil, mediaType: [MediaSourceType], commpletion: ((_ image: UIImage?, _ info: [UIImagePickerController.InfoKey : Any]?) -> ())?) {
        
        self.allowsEditing = isEditing
        
        let mediaSourceTypes = mediaType.removeDuplicates()
        var actions : [AAction] = []
        let _ = mediaSourceTypes.compactMap({actions.append(AAction.Custom(title: $0.strValue))})
        guard !actions.isEmpty else {
            return
        }
        actions.append(.Cancel)
        
        topMostViewController?.alertView(title: title, message: message, style: .actionSheet, actions: actions, handler: { [weak self] (action) in
            guard let self = self else { return }
            if action == AAction.Cancel { return }
            guard let index = actions.indexes(of: action).first else { return }
            let medisSource = mediaType[index]
            medisSource.takeAppropriateAction(mediaManager: self)
        })
        self.commpletion = commpletion
    }
    
    func openCamera(isEditing: Bool = false,cameraType: UIImagePickerController.CameraDevice = .rear, commpletion: ((_ image: UIImage?, _ info: [UIImagePickerController.InfoKey : Any]?) -> ())?) {
        
        self.allowsEditing = isEditing
        takeAPhoto(cameraType: cameraType)
        self.commpletion = commpletion
    }
    func openGallery(isEditing: Bool = false, commpletion: ((_ image: UIImage?, _ info: [UIImagePickerController.InfoKey : Any]?) -> ())?) {
        
        self.allowsEditing = isEditing
        takeAPhotoGallery()
        self.commpletion = commpletion
    }
    
    /// A private method used to select an image from camera.
    private func takeAPhoto(cameraType: UIImagePickerController.CameraDevice) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else{
            let msg = "Your device doesn't support camera."
            topMostViewController?.alertView(message:msg,actions: [.Ok])
            return
        }
        
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                CGCDMainThread.async {
                    self.imagePickerController.sourceType = .camera
                    self.imagePickerController.allowsEditing = false
                    self.imagePickerController.cameraDevice = cameraType
                    topMostViewController?.present(self.imagePickerController, animated: true, completion: nil)
                }
            } else {
                CGCDMainThread.async {
                    topMostViewController?.alertView(title: "", message: AppMessages.CCameraNotAllow, style: .alert, actions: [.Cancel, .Setting], handler: {[weak self] sender in
                        
                        guard let `_` = self else {
                            return
                        }
                        
                        if sender == .Setting {
                            if let url = URL.init(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    })
                }
            }
        }
    }
    
    /// A private method used to select an image from camera.
    private func takeAPhotoGallery() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else{
            let msg = "Your device doesn't support camera."
            topMostViewController?.alertView(message:msg,actions: [.Ok])
            return
        }
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        topMostViewController?.present(imagePickerController, animated: true, completion: nil)
    }
    
    /// A private method used to select an image from photoLibrary.
    private func chooseFromPhotoLibrary() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            let msg = "Your device doesn't support photo library."
            topMostViewController?.alertView(message:msg,actions: [.Ok])
            return
        }
        
        // Request permission to access photo library
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { [unowned self] (status) in
                
                CGCDMainThread.async { [unowned self] in
                    showUI(for: status)
                }
            }
        } else {
            // Fallback on earlier versions
            PHPhotoLibrary.requestAuthorization { (status) in
                
                switch status {
                case .restricted, .denied:
                    self.showRestrictedAccessUI()
                    
                case .authorized:
                    CGCDMainThread.async {
                        self.imagePickerController.sourceType = .photoLibrary
                        self.imagePickerController.allowsEditing = self.allowsEditing
                        topMostViewController?.present(self.imagePickerController, animated: true, completion: nil)
                    }
                default:
                    break
                }
                
            }
        }

    }
    
    func showUI(for status: PHAuthorizationStatus) {
        
        switch status {
        case .authorized:
            showFullAccessUI()
            
        case .limited:
            //showLimittedAccessUI()
            showFullAccessUI()
            
        case .restricted:
            showRestrictedAccessUI()
            
        case .denied:
            showAccessDeniedUI()
            
        case .notDetermined:
            break
            
        @unknown default:
            break
        }
    }
    
    func showFullAccessUI() {
        CGCDMainThread.async {
            self.imagePickerController.sourceType = .photoLibrary
            self.imagePickerController.allowsEditing = self.allowsEditing
            topMostViewController?.present(self.imagePickerController, animated: true, completion: nil)
        }
    }
    
    func showRestrictedAccessUI() {
        CGCDMainThread.async {
            topMostViewController?.alertView(title: "", message: AppMessages.CGalleryNotAllow, style: .alert, actions: [.Cancel, .Setting], handler: {[weak self] sender in
                
                guard let `self` = self else {
                    return
                }
                
                if sender == .Setting {
                    if let url = URL.init(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            })
        }
    }
    
    func showAccessDeniedUI() {
        CGCDMainThread.async {
            topMostViewController?.alertView(title: "", message: AppMessages.CGalleryNotAllow, style: .alert, actions: [.Cancel, .Setting], handler: {[weak self] sender in
                
                guard let `self` = self else {
                    return
                }
                
                if sender == .Setting {
                    if let url = URL.init(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            })
        }
    }
    
    /// A private method used to select an image from savedPhotosAlbum.
    private func chooseFromSavedPhotosAlbum() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) else {
            let msg = "Your device doesn't support photo library."
            topMostViewController?.alertView(message:msg,actions: [.Ok])
            return
        }
        
        // Request permission to access photo library
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { [unowned self] (status) in
                
                CGCDMainThread.async { [unowned self] in
                    showUI(for: status)
                }
            }
        } else {
            // Fallback on earlier versions
            PHPhotoLibrary.requestAuthorization { (status) in
                
                switch status {
                case .restricted, .denied:
                    self.showRestrictedAccessUI()
                    
                case .authorized:
                    CGCDMainThread.async {
                        self.imagePickerController.sourceType = .savedPhotosAlbum
                        self.imagePickerController.allowsEditing = self.allowsEditing
                        topMostViewController?.present(self.imagePickerController, animated: true, completion: nil)
                    }
                default:
                    break
                }
                
            }
        }
        

    }
}

// MARK:- ImagePicker Delegate -
extension MediaManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true) { [weak self] in
            
            guard let self = self, let commpletion = self.commpletion else {
                return
            }
            
            var image:UIImage?
            if (self.allowsEditing) {
                image = info[.editedImage] as? UIImage
            } else {
                image = info[.originalImage] as? UIImage
            }
            
            commpletion(image, info)
        }
    }
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true) { [weak self] in
            
            guard let self = self, let commpletion = self.commpletion else {
                return
            }
            commpletion(nil, nil)
        }
    }
}

extension MediaManager {
    
    func phAssetController(mediaType : PHAssetMediaType = .image, limit: Int? = nil, ascending: Bool? = nil, completion: ((_ images: PHFetchResult<PHAsset>?) -> ())?) {
        
        
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                let fetchOptions = PHFetchOptions()
                if let `limit` = limit {
                    fetchOptions.fetchLimit = limit
                }
                
                if let `ascending` = ascending {
                    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: ascending)]
                }
                
                AppLogs.debugPrint("fetchOptions == = \(fetchOptions)")
                
                var arrAssets = PHFetchResult<PHAsset>()
                arrAssets = PHAsset.fetchAssets(with: mediaType, options: fetchOptions)
                
                if let `completion` = completion {
                    
                    completion(arrAssets)
                }
                
            case .denied:
                self.showAccessDeniedUI()
                
            case .restricted:
                self.showRestrictedAccessUI()
                
            case .notDetermined:
                // Should not see this when requesting
                AppLogs.debugPrint("Not determined yet")
                break
            case .limited:
                self.showRestrictedAccessUI()
                AppLogs.debugPrint("limited")
            default:
                break
            }
        }
        
    }
}
