//
//  ListViewModel.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import RxSwift
import RxCocoa

class ListViewModel {
    
    struct Inputs {
        let search: Driver<String>
        let reachedBottom: Observable<Void>
    }
    
    struct Outputs {
        let albums: Driver<[ListSectionModel]>
        let numberOfAlbums: Driver<String>
    }
    
    let searchUseCase: SearchUseCaseProtocol
    
    init(with useCase: SearchUseCaseProtocol) {
        self.searchUseCase = useCase
    }
    
    func transform(_ inputs: ListViewModel.Inputs) -> Outputs {
        
        let outputs = searchUseCase.transform(SearchUseCase.Inputs(loadNextPage: inputs.reachedBottom,
                                                                   loadSearch: inputs.search.asObservable()))
        
        let albums = outputs.albums.map { [ListSectionModel](with: $0) }.asDriver(onErrorJustReturn: [])
        let numberOfAlbums = outputs.albums.map { "\($0.count)" }.asDriver(onErrorJustReturn: "")
        
        
        return ListViewModel.Outputs(
            albums: albums,
            numberOfAlbums: numberOfAlbums
        )
    }
}
