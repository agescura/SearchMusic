//
//  AlbumDTO.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 23/2/21.
//

public struct Album: Codable {
    public let country: String?
    public let title: String
    public let genre: [String]?
    public let year: String?
}
