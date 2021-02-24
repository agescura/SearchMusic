//
//  DiscogsRepository.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 23/2/21.
//

import RxSwift
import Moya

class DiscogsRepository: TransformType {
    
    // MARK: Service
    
    private let provider = MoyaProvider<DiscogsService>()
    
    // MARK: Transform Type
    
    func transform(input: Input) -> Output {
        let source = PaginationUISource(search: input.search,
                                        loadNextPage: input.loadNextPage)
        let sink = PaginationSink(ui: source, loadData: search(album:page:))
        
        return Output(
            albums: sink.elements
        )
    }
    
    // MARK: Private Methods
    
    private func search(album: String, page:Int) -> Single<[Album]> {
        provider.rx.request(.search(album: album, page: page))
            .map(SearchDTO.self)
            .map([Album].init)
    }
}

extension DiscogsRepository {
    struct Input {
        let search: Observable<String>
        let loadNextPage: Observable<Void>
    }
    
    struct Output {
        let albums: Observable<[Album]>
    }
}
