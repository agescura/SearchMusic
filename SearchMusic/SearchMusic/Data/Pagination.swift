//
//  Pagination.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 23/2/21.
//

import RxSwift

struct PaginationQuery {
    let search: String
    let page: Int
}

struct PaginationUISource {
    let search: Observable<String>
    /// loads next page
    let loadNextPage: Observable<Void>
}

struct PaginationSink<T> {
    /// true if network loading is in progress.
    let isLoading: Observable<Bool>
    /// elements from all loaded pages
    let elements: Observable<[T]>
    /// fires once for each error
    let error: Observable<Error>
}

extension PaginationSink {
    
    init(ui: PaginationUISource, loadData: @escaping (_ q: String, _ page: Int) -> Single<[T]>)
    {
        let loadResults = BehaviorSubject<[Int: [T]]>(value: [:])
        
        let maxPage = loadResults
            .map { $0.keys }
            .map { $0.max() ?? 1 }
        
        let reload = ui.search.map { _ in }
            .map { -1 }
        
        let loadNext = ui.loadNextPage
            .withLatestFrom(maxPage)
            .map { $0 + 1 }
        
        let start = Observable.merge(reload, loadNext, Observable.just(1))
        
        let page = Observable.combineLatest(start, ui.search) { ($0, $1) }
            .flatMap { combine -> Observable<Event<(pageNumber: Int, items: [T])>> in
                let page = combine.0
                let search = combine.1
                return Observable.combineLatest(Observable.just(page), loadData(search, page == -1 ? 1 : page).asObservable()) { (pageNumber: $0, items: $1) }
                    .materialize()
                    .filter { $0.isCompleted == false }
            }
            .share()
        
        _ = page
            .compactMap { $0.element }
            .withLatestFrom(loadResults) { (pages: $1, newPage: $0) }
            .filter { $0.newPage.pageNumber == -1 || !$0.newPage.items.isEmpty }
            .map { $0.newPage.pageNumber == -1 ? [1: $0.newPage.items] : $0.pages.merging([$0.newPage], uniquingKeysWith: { $1 }) }
            .subscribe(loadResults)
        
        let _isLoading = Observable.merge(start.map { _ in 1 }, page.map { _ in -1 })
            .scan(0, accumulator: +)
            .map { $0 > 0 }
            .distinctUntilChanged()
        
        let _elements = loadResults
            .map { $0.sorted(by: { $0.key < $1.key }).flatMap { $0.value } }
        
        let _error = page
            .map { $0.error }
            .filter { $0 != nil }
            .map { $0! }
        
        isLoading = _isLoading
        elements = _elements
        error = _error
    }
}
