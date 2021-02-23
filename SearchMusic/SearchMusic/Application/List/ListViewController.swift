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
    
    // MARK: - RxDataSources
    
    let dataSource = RxTableViewSectionedReloadDataSource<ListSectionModel>(
      configureCell: { dataSource, tableView, indexPath, item in
        switch dataSource[indexPath] {
        case .search(viewModel: let viewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell",
                                                     for: indexPath) as! ListTableViewCell
            cell.viewModel = viewModel
            return cell
        case .message:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell",
                                                     for: indexPath) as! MessageTableViewCell
            return cell
        }
    })
    
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
            .catchErrorJustReturn(ListSectionModel.message)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        viewModel.numberOfAlbums
            .catchErrorJustReturn("Error")
            .bind(to: rx.title)
            .disposed(by: bag)
    }
}
