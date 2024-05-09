//
//  UIImage+Extension.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    var cropRatio: CGFloat {
        let widthRatio = CGFloat(self.size.width / self.size.height)
        return widthRatio
    }
    
    func toResizedData() -> Data? {
        if let resized = self.resizeImageTo(scaledToWidth: 800.0) {
            return resized.jpegData(compressionQuality: 1.0)
        }
        return self.jpegData(compressionQuality: 0.9)
    }
    
    func toData() -> Data? {
        return self.jpegData(compressionQuality: 0.5)
    }
    
    func toGetImageMBSize() -> String? {
        if let data = self.pngData() {
            print("There were \(data.count) bytes")
            let bcf = ByteCountFormatter()
            bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
            bcf.countStyle = .file
            let stringSize = bcf.string(fromByteCount: Int64(data.count))
            print("formatted result: \(stringSize)")
            return stringSize
        }
        return ""
    }
    
    func resizeImageTo(scaledToWidth: CGFloat) -> UIImage? {
        let oldWidth = self.size.width
        if oldWidth < scaledToWidth {
            return self
        }
        let scaleFactor = scaledToWidth / oldWidth
        
        let newHeight = self.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        
        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        self.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    var data : Data? {
        return self.jpegData(compressionQuality: 1.0)
    }
    
    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        
        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    var noir: UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = currentFilter.outputImage,
           let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
}
