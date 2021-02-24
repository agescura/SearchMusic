//
//  ListViewModel.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import RxSwift
import RxCocoa

class ListViewModel: TransformType {
    
    let searchUseCase: SearchUseCase
    
    init(with useCase: SearchUseCase) {
        self.searchUseCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let search = input.search
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .filter { $0.count > 3 }
        
        let inputs = SearchUseCase.Input(search: search,
                                         loadNextPage: input.loadNextPage)
        let outputs = searchUseCase.transform(input: inputs)
        
        let albums = outputs.albums
            .map { [ListSectionModel](with: $0) }
            .catchErrorJustReturn(ListSectionModel.message)
        
        let isLoading = Observable
            .merge(input.loadNextPage.map { _ in true },
                   outputs.albums.map { _ in false })
            .startWith(false)
        
        let numberOfAlbums = Observable.combineLatest(outputs.albums, isLoading)
            { albums, isLoading in "\(albums.count) \(isLoading ? "- Loading" : "")" }
            .catchErrorJustReturn("Error")
        
        return Output(
            albums: albums,
            numberOfAlbums: numberOfAlbums
        )
    }
}

extension ListViewModel {
    
    struct Input {
        let search: Observable<String>
        let loadNextPage: Observable<Void>
    }
    
    struct Output {
        let albums: Observable<[ListSectionModel]>
        let numberOfAlbums: Observable<String>
    }
}
