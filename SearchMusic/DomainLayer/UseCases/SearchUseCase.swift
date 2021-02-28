//
//  SearchUseCase.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import RxSwift
import DataLayer

public class SearchUseCase: TransformType {
    
    // MARK: Repository
    
    private let repository: DiscogsRepository
    
    // MARK: Init
    
    public init(with repository: DiscogsRepository) {
        self.repository = repository
    }
    
    // MARK: - Transform Type
    
    public func transform(input: Input) -> Output {
        let input = DiscogsRepository.Input(search: input.search,
                                            loadNextPage: input.loadNextPage)
        let outputs = repository.transform(input: input)
        
        return Output(
            albums: outputs.albums
                .map([Album].init)
        )
    }
}

public extension SearchUseCase {
    struct Input {
        let search: Observable<String>
        let loadNextPage: Observable<Void>
        
        public init(search: Observable<String>, loadNextPage: Observable<Void>) {
            self.search = search
            self.loadNextPage = loadNextPage
        }
    }
    
    struct Output {
        public let albums: Observable<[Album]>
    }
}
