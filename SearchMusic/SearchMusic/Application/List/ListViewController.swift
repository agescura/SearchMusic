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
        
        let outputs = viewModel.transform(ListViewModel.Inputs(
            search: searchController.rx.search.asDriver(onErrorDriveWith: .empty()).debounce(.milliseconds(500)).filter { $0.count > 3 },
            reachedBottom: tableView.rx.reachedBottom(offset: 100).asObservable()
        ))
        
        outputs.albums
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        outputs.numberOfAlbums
            .drive(rx.title)
            .disposed(by: bag)
        
    }
}

extension Reactive where Base: UIScrollView {
    
    func reachedBottom(offset: CGFloat = 0.0) -> ControlEvent<Void> {
        let source = contentOffset.map { contentOffset in
            let visibleHeight = self.base.frame.height - self.base.contentInset.top - self.base.contentInset.bottom
            let y = contentOffset.y + self.base.contentInset.top
            let threshold = max(offset, self.base.contentSize.height - visibleHeight)
            return y >= threshold
        }
        .distinctUntilChanged()
        .filter { $0 }
        .map { _ in () }
        return ControlEvent(events: source)
    }
}

public extension Reactive where Base: UISearchController {
    
    var delegate: DelegateProxy<UISearchController, UISearchResultsUpdating> {
        return RxSearchResultsUpdatingProxy.proxy(for: base)
    }
    
    var search: Observable<String> {
        return RxSearchResultsUpdatingProxy.proxy(for: base).searchPhraseSubject.asObservable()
    }
}

class RxSearchResultsUpdatingProxy: DelegateProxy<UISearchController, UISearchResultsUpdating>, UISearchResultsUpdating {

    lazy var searchPhraseSubject = PublishSubject<String>()
    
    init(searchController: UISearchController) {
        super.init(parentObject: searchController, delegateProxy: RxSearchResultsUpdatingProxy.self)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchPhraseSubject.onNext(searchController.searchBar.text ?? "")
    }
}

extension RxSearchResultsUpdatingProxy: DelegateProxyType {
    static func currentDelegate(for object: UISearchController) -> UISearchResultsUpdating? {
        return object.searchResultsUpdater
    }
    
    static func setCurrentDelegate(_ delegate: UISearchResultsUpdating?, to object: UISearchController) {
        object.searchResultsUpdater = delegate
    }
    
    static func registerKnownImplementations() {
        register { RxSearchResultsUpdatingProxy(searchController: $0) }
    }
}
