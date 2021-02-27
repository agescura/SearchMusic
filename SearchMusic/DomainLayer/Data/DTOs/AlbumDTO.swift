//
//  AlbumDTO.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 23/2/21.
//

import Foundation

struct AlbumsDTO: Codable {
    let country: String?
    let title: String
    let genre: [String]?
    let year: String?
}
