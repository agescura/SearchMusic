//
//  SearchDTO.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 23/2/21.
//

import Foundation

struct SearchDTO: Codable {
    let albums: [AlbumsDTO]
    
    enum CodingKeys: String, CodingKey {
        case albums = "results"
    }
}