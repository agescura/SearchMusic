//
//  Album+AlbumDTO.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 24/2/21.
//

import Foundation
import DataLayer

extension Album {
    init(with dto: AlbumDTO) {
        self.country = dto.country
        self.genre = dto.genre ?? []
        self.title = dto.title
        self.year = dto.year
    }
}
