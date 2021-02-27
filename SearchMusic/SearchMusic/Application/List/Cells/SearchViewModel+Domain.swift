//
//  SearchViewModel+Domain.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 27/2/21.
//

import DomainLayer

extension SearchViewModel {
    init(with album: Album) {
        self.title = album.title
        self.subtitle = album.genre.joined(separator: ",")
        self.leftText = album.country
        self.rightText = album.year
    }
}

extension Array where Element == SearchSectionModel {
    init(with albums: [Album]) {
        self = albums.isEmpty ? [] :
            [.section(items: albums.map { .search(viewModel: SearchViewModel(with: $0))})]
    }
}
