//
//  UIStackView+addArrangedSubviews.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
            for view in views {
                addArrangedSubview(view)
            }
        }
}
