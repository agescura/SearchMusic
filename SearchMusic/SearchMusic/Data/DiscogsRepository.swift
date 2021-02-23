//
//  DiscogsRepository.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 23/2/21.
//

import RxSwift
import Moya

protocol MusicRepository {
    func albums(q: String) -> Single<SearchDTO>
}

class DiscogsRepository: MusicRepository {
    
    // MARK: Service
    
    private let provider = MoyaProvider<DiscogsService>()
    
    // MARK: Public Methods
    
    func albums(q: String) -> Single<SearchDTO> {
        provider.rx.request(.searchAlbums(q: q))
            .map(SearchDTO.self)
    }
}
