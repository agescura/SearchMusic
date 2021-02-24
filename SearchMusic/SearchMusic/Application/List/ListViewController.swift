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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let inputs = ListViewModel.Input(
            search: searchController.rx.search,
            loadNextPage: tableView.rx.reachedBottom(offset: 100).asObservable()
        )
        let outputs = viewModel.transform(input: inputs)
        
        outputs.albums
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        outputs.numberOfAlbums
            .bind(to: rx.title)
            .disposed(by: bag)
    }
}
