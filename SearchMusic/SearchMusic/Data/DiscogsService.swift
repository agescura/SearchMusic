//
//  DiscogsService.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 23/2/21.
//

import RxSwift
import RxAlamofire
import Alamofire

protocol MusicService {
    func albums(q: String) -> Observable<SearchDTO>
}

class DiscogsService: MusicService {
    
    // MARK: Service
    
    private let manager = Alamofire.Session.default
    
    // MARK: Public Methods
    
    func albums(q: String) -> Observable<SearchDTO> {
        return get("https://api.discogs.com/database/search?q=\(q)&key=RJzRdxSSJZoUmwgCyyPG&secret=ohfTefiIpsuelDjeXBgUxveQgnIOjLfO&page=2")
            .mapObject(type: SearchDTO.self)
    }
    
    // MARK: Private methods
    
    fileprivate func get(_ path: String) -> Observable<Data> {
        return manager.rx
            .data(.get, path)
            .observe(on: MainScheduler.instance)
    }
}

struct SearchDTO: Codable {
    let albums: [AlbumsDTO]
    
    enum CodingKeys: String, CodingKey {
        case albums = "results"
    }
}

struct AlbumsDTO: Codable {
    let country: String?
    let title: String
    let genre: [String]?
    let year: String?
}
