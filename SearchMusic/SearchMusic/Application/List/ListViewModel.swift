//
//  ListViewModel.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import RxSwift

class ListViewModel {
    
    let searchUseCase: SearchUseCaseProtocol
    
    init(with useCase: SearchUseCaseProtocol) {
        self.searchUseCase = useCase
    }
    
    lazy var albums: Observable<[ListSectionModel]> = searchUseCase.albums
        .map { [ListSectionModel](with: $0) }
    
    lazy var numberOfAlbums: Observable<String> = searchUseCase.albums.map { "\($0.count)" }
}
