//
//  ListViewController.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 19/2/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class ListViewController: UIViewController {
    
    // MARK: - ViewModel
    
    var viewModel: ListViewModel!
    
    // MARK: - Outlets
    
    private let tableView = TableView()
    
    // MARK: - Bag
    
    private let bag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        viewModel.albums
            .bind(to: tableView.rx.items(ListTableViewCell.self)) { _, model, cell in
                cell.viewModel = model
            }
            .disposed(by: bag)
        
        viewModel.albums
            .map { "\($0.count)" }
            .bind(to: rx.title)
            .disposed(by: bag)
    }
}
