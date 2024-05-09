//
//  ExtensionUITableView.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit
import Combine

extension UITableView {
    
    private enum FooterType: Int {
        case loadingMore = 1234567890
    }
    
    func enableNoDataView(message: String) {
        
        if let noDataView = NoDataView.viewFromXib as? NoDataView {
            
            noDataView.frame = self.frame
            noDataView.lblMessage.text = message
            
            backgroundView = noDataView
        }
    }
    
    func disableNoDataView() {
        
        if backgroundView != nil {
            backgroundView = nil
        }
    }
    
    /// It will show the loading indicator while fetching the new data.
    /// - Parameters:
    ///   - color: A UIColor Value that indicates the Color of UIActivityIndicatorView.
    func addLoadMoreIndicator(
        color: UIColor = .black,
        style: UIActivityIndicatorView.Style = .medium
    ) {
        
        let footerView = UIView(frame: CGRect(
            x: 0.0,
            y: 0.0,
            width: UIDevice.screenWidth,
            height: 40.0)
        )
        
        footerView.tag = FooterType.loadingMore.rawValue
        
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.startAnimating()
        activityIndicator.color = color;
        activityIndicator.frame = footerView.frame
        footerView.addSubview(activityIndicator)
        
        tableFooterView = footerView
    }
    
    /// This method will remove the loading indicator if added in the tableFooterView.
    func removeLoadMoreIndicator() {
        
        if tableFooterView != nil,
            tableFooterView?.tag == FooterType.loadingMore.rawValue {
            tableFooterView = nil
        }
    }
}

extension UITableView {

    var pullToRefreshControl: UIRefreshControl? {
        get {
            if #available(iOS 10.0, *) {
                return self.refreshControl
            } else {
                return self.viewWithTag(9876) as? UIRefreshControl
            }
        } set {
            if #available(iOS 10.0, *) {
                self.refreshControl = newValue
            } else {
                if let refreshControl = newValue {
                    refreshControl.tag = 9876
                    self.addSubview(refreshControl)
                }
            }
        }
    }
    
    var lastIndexPath: IndexPath? {
        let sections = self.numberOfSections
        
        if (sections<=0){
            return nil
        }
        
        let rows = self.numberOfRows(inSection: sections-1)
        
        if (rows<=0){return nil}
        
        return IndexPath(row: rows-1, section: sections-1)
    }
    
    var dummyCell: UITableViewCell {
        let defaultCell = UITableViewCell(frame: .zero)
        defaultCell.selectionStyle = .none
        return defaultCell
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    func scrollToTop() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
  
    func updateHeaderViewHeight(extxtraSpace:CGFloat = 0) {
        DispatchQueue.main.async {
            if let headerView = self.tableHeaderView {
                headerView.setNeedsLayout()
                headerView.layoutIfNeeded()
                headerView.sizeToFit()
                let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
                var headerFrame = headerView.frame
                
                //Comparison necessary to avoid infinite loop
                if height != headerFrame.size.height {
                    headerFrame.size.height = height + extxtraSpace
                    headerView.frame = headerFrame
                    self.tableHeaderView = headerView
                    self.layoutIfNeeded()
                }
            }
        }
    }
}

extension UITableView {

    func automaticHeaderViewSize() {
        
        if let headerView = self.tableHeaderView {
            
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
            
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var headerFrame = headerView.frame
            
            //Comparison necessary to avoid infinite loop
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                self.tableHeaderView = headerView
            }
            self.tableHeaderView = headerView
        }
    }
    
    func performUpdate(_ update: ()->Void, completion: (()->Void)?) {
        if #available(iOS 11.0, *) {
            performBatchUpdates({
                update()
            }) { (isCompleted) in
                if !isCompleted { return }
                if let blk = completion { blk() }
            }
        } else {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            
            beginUpdates()
            update()
            endUpdates()
            
            CATransaction.commit()
        }
    }
    
    func setEmptyMessage(_ message: String) {
        
        let view = UIView()
        self.backgroundView = view;
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.numberOfLines = 0;
        messageLabel.textColor = UIColor.gray
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.custom(name: .montserratRegular, size: (16 * UIDevice.screenWidth) / 414)
        
        messageLabel.sizeToFit()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)
        
        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
    public func relayoutTableHeaderView() {
        if let tableHeaderView = tableHeaderView {
            let labels = tableHeaderView.findViewsOfClass(viewClass: UILabel.self)
            for label in labels {
                label.preferredMaxLayoutWidth = label.frame.width
            }
            tableHeaderView.setNeedsLayout()
            tableHeaderView.layoutIfNeeded()
            
            let height = tableHeaderView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var headerFrame = tableHeaderView.frame
            
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                tableHeaderView.frame = headerFrame
                self.tableHeaderView = tableHeaderView
            }
            self.tableHeaderView = tableHeaderView
        }
    }
    
    func activityLoader(_ indexPath: IndexPath) {
        
        let lastSectionIndex = self.numberOfSections - 1
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView()
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.bounds.width, height: CGFloat(44))
            spinner.color = .red
            
            self.tableFooterView = spinner
            self.tableFooterView?.isHidden = false
        }
    }
}

extension UITableView {
    func reloadRow(index: Int, section: Int = 0, animation: UITableView.RowAnimation = .none) {
        let newIndexpath = IndexPath(row: index, section: section)
        
        if let visibleIndexpath = self.indexPathsForVisibleRows,
        !visibleIndexpath.isEmpty,
        visibleIndexpath.contains(where: { indexpath in
            return indexpath == newIndexpath
        }){
            self.reloadRows(at: [newIndexpath], with: animation)
        }
    }
}

var tableCancelBag: Set<AnyCancellable> = []
extension UIScrollView {
    func contentSize(completion: ((_ contentSize: CGSize)->Void)?) {
        self
            .publisher(for: \.contentSize)
            .receive(on: DispatchQueue.main)
            .compactMap({ $0 })
            .sink { [weak self] (contentSize) in
                guard let `self` = self else { return }
                if let block = completion {
                    block(contentSize)
                }
            }.store(in: &tableCancelBag)
    }
}
