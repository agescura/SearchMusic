//
//  DiscogsRepository.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 23/2/21.
//

import RxSwift
import Moya

public class DiscogsRepository: TransformType {
    
    // MARK: Service
    
    private let provider = MoyaProvider<DiscogsService>()
    
    // MARK: Init
    
    public init() {}
    
    // MARK: Transform Type
    
    public func transform(input: Input) -> Output {
        let source = PaginationUISource(search: input.search,
                                        loadNextPage: input.loadNextPage)
        let sink = PaginationSink(ui: source, loadData: search(album:page:))
        
        return Output(
            albums: sink.elements
        )
    }
    
    // MARK: Private Methods
    
    private func search(album: String, page:Int) -> Single<[AlbumDTO]> {
        provider.rx.request(.search(album: album, page: page))
            .map(SearchDTO.self)
            .map { $0.albums }
    }
}

public extension DiscogsRepository {
    struct Input {
        let search: Observable<String>
        let loadNextPage: Observable<Void>
        
        public init(search: Observable<String>, loadNextPage: Observable<Void>) {
            self.search = search
            self.loadNextPage = loadNextPage
        }
    }
    
    struct Output {
        public let albums: Observable<[AlbumDTO]>
    }
}
