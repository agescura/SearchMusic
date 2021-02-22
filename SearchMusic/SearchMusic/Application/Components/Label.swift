//
//  Label.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import UIKit

class Label: UILabel {
    
    init(with font: UIFont = .systemFont(ofSize: 16),
         textColor: UIColor = .black) {
        super.init(frame: .zero)
        
        self.font = font
        self.textColor = textColor
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
