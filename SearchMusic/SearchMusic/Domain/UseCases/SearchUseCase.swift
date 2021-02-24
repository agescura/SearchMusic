//
//  SearchUseCase.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import RxSwift

class SearchUseCase: TransformType {
    
    // MARK: Repository
    
    private let repository: DiscogsRepository
    
    // MARK: Init
    
    init(with repository: DiscogsRepository) {
        self.repository = repository
    }
    
    // MARK: - Transform Type
    
    func transform(input: Input) -> Output {
        let input = DiscogsRepository.Input(search: input.search,
                                            loadNextPage: input.loadNextPage)
        let outputs = repository.transform(input: input)
        
        return Output(
            albums: outputs.albums
        )
    }
}

extension SearchUseCase {
    struct Input {
        let search: Observable<String>
        let loadNextPage: Observable<Void>
    }
    
    struct Output {
        let albums: Observable<[Album]>
    }
}
