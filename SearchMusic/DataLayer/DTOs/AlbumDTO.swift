//
//  AlbumDTO.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 23/2/21.
//

import Foundation

public struct AlbumDTO: Codable {
    public let country: String?
    public let title: String
    public let genre: [String]?
    public let year: String?
}
