//
//  Array+Album.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 24/2/21.
//

import Foundation

extension Array where Element==Album {
    init(with search: SearchDTO) {
        self = search.albums.map(Album.init)
    }
}
