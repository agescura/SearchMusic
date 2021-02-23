//
//  SearchUseCase.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import RxSwift

protocol SearchUseCaseProtocol {
    var albums: Observable<[Album]> { get }
}

class SearchUseCase: SearchUseCaseProtocol {
    
    private let service: MusicService
    
    init(with service: MusicService) {
        self.service = service
    }
    
    lazy var albums: Observable<[Album]> = service.albums(q: "Nirvana").map { $0.albums.map(Album.init) }
}

extension Album {
    init(with dto: AlbumsDTO) {
        self.country = dto.country
        self.genre = dto.genre ?? []
        self.title = dto.title
        self.year = dto.year
    }
}
