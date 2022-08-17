//
//  TableViewExtensions.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//

import UIKit

extension UITableView {
    func reloadIfNeeded() {
        if Thread.isMainThread {
            self.reloadData()
        } else {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
}
