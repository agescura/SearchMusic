//
//  UISearchController+Rx.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 24/2/21.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UISearchController {
    
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
