//
//  Album.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

public struct Album {
    public let title: String
    public let genre: [String]
    public let country: String?
    public let year: String?
    public let url: String
}

extension Album: Equatable {}
