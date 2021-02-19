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
    
    // MARK: - Fakes (temporal)
    
    private let albums: Observable<[String]> = .just([
        "London Calling",
        "Ok Computer",
        "Hunky Dory",
        "Dark Side Of The Moon",
        "Fear of Music"
    ])
    
    // MARK: - Outlets
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self,
                      forCellReuseIdentifier: "UITableViewCell")
        view.tableFooterView = UIView()
        return view
    }()
    
    // MARK: - Bag
    
    private let bag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        albums
            .bind(to: tableView.rx.items(cellIdentifier: "UITableViewCell")) { _, model, cell in
                cell.textLabel?.text = model
            }
            .disposed(by: bag)
        
        albums
            .map { "\($0.count)" }
            .bind(to: rx.title)
            .disposed(by: bag)
    }
}
