//
//  Album+Data.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 24/2/21.
//

import DataLayer

extension Album {
    init(with dto: DataLayer.Album) {
        self.country = dto.country
        self.genre = dto.genre ?? []
        self.title = dto.title
        self.year = dto.year
        self.url = dto.url
    }
}

extension Array where Element==Album {
    init(with dtos: [DataLayer.Album]) {
        self = dtos.map(Album.init)
    }
}
