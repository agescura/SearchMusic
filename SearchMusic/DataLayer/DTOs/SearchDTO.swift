//
//  SearchDTO.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 23/2/21.
//

struct SearchDTO: Codable {
    let albums: [Album]
    
    enum CodingKeys: String, CodingKey {
        case albums = "results"
    }
}
