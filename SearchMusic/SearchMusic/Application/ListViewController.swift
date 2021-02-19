//
//  ListViewController.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 19/2/21.
//

import UIKit
import SnapKit

class ListViewController: UIViewController {
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
