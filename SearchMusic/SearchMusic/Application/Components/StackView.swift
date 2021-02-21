//
//  StackView.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import UIKit

class StackView: UIStackView {
    
    init(with axis: NSLayoutConstraint.Axis = .vertical,
         and distribution: UIStackView.Distribution = .equalSpacing) {
        super.init(frame: .zero)
        
        self.axis = axis
        self.distribution = distribution
        self.spacing = 8
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
