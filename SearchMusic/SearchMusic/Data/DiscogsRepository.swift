//
//  DiscogsRepository.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 23/2/21.
//

import RxSwift
import Moya

protocol MusicRepository {
    func transform(_ inputs: DiscogsRepository.Inputs) -> DiscogsRepository.Outputs
}

class DiscogsRepository: MusicRepository {
    
    struct Inputs {
        let search: Observable<String>
        let loadNextPage: Observable<Void>
    }
    
    struct Outputs {
        let albums: Observable<[Album]>
    }
    
    func transform(_ inputs: Inputs) -> Outputs {
        let source = PaginationUISource(search: inputs.search,
                                        loadNextPage: inputs.loadNextPage)
        let sink = PaginationSink(ui: source, loadData: search(q:page:))
        
        return Outputs(
            albums: sink.elements
        )
    }
    
    // MARK: Service
    
    private let provider = MoyaProvider<DiscogsService>()
    
    // MARK: Public Methods
    
    private func search(q: String, page:Int) -> Single<[Album]> {
        provider.rx.request(.searchAlbums(q: q, p: page))
            .map(SearchDTO.self)
            .map { $0.albums.map(Album.init) }
    }
}
