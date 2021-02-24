//
//  SearchUseCase.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import RxSwift

protocol SearchUseCaseProtocol {
    func transform(_ inputs: SearchUseCase.Inputs) -> SearchUseCase.Outputs
}

class SearchUseCase: SearchUseCaseProtocol {
    
    struct Inputs {
        let loadNextPage: Observable<Void>
        let loadSearch: Observable<String>
    }
    
    struct Outputs {
        let albums: Observable<[Album]>
    }
    
    private let repository: MusicRepository
    
    let loadNextPage = PublishSubject<Void>()
    let loadSearch = PublishSubject<String>()
    
    init(with repository: MusicRepository) {
        self.repository = repository
    }
    
    func transform(_ inputs: SearchUseCase.Inputs) -> SearchUseCase.Outputs {
        let outputs = repository.transform(DiscogsRepository.Inputs(search: inputs.loadSearch, loadNextPage: inputs.loadNextPage))
        
        return SearchUseCase.Outputs(albums: outputs.albums)
    }
}

extension Album {
    init(with dto: AlbumsDTO) {
        self.country = dto.country
        self.genre = dto.genre ?? []
        self.title = dto.title
        self.year = dto.year
    }
}
