//
//  UITableView+register.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import UIKit

extension UITableView {
    func register(_ cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
}
