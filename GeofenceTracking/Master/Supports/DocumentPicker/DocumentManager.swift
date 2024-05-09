//
//  DocumentManager.swift
//  IRlJobs
//
//  Created by Krishna Soni on 26/05/21.
//

import Foundation
import UIKit

final class DocumentManager: NSObject {
    
    /// Shared(Singleton) object of DocumentManager class.
    static let shared: DocumentManager = DocumentManager()
    
    private(set) var commpletion: ((_ urls: [URL]) -> ())?
}

extension DocumentManager: UIDocumentPickerDelegate {
    
    func openPicker(commpletion: ((_ urls: [URL]) -> ())?) {
        
        guard let topMostVC = UIApplication.shared.topMostVC() else {
            return
        }
        
        self.commpletion = commpletion
        
        let controller = UIDocumentPickerViewController(
            documentTypes: ["public.text","com.adobe.pdf"], // choose your desired documents the user is allowed to select
            in: .import // choose your desired UIDocumentPickerMode
        )
        
        controller.delegate = self
        if #available(iOS 11.0, *) {
            controller.allowsMultipleSelection = false
        }
        
        topMostVC.present(controller, animated: true, completion: nil)
    }
    
    @available(iOS 11.0, *)
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let commpletion = self.commpletion else {
            return
        }
        
        commpletion(urls)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        // do something with the selected document
        AppLogs.debugPrint(url)
    }
}
