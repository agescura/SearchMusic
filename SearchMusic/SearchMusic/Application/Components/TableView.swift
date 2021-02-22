//
//  TableView.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import UIKit

class TableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        register(ListTableViewCell.self)
        register(MessageTableViewCell.self)
        tableFooterView = UIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

