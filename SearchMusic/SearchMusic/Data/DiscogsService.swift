//
//  DiscogsService.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 23/2/21.
//

import Moya

enum DiscogsService: TargetType {
    case searchAlbums(q: String, p: Int)
    
    var baseURL: URL {
        URL(string: "https://api.discogs.com/database")!
    }
    
    var path: String {
        switch self {
        case .searchAlbums:
            return "/search"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
      switch self {
      case .searchAlbums(q: let q, p: let p):
        return .requestParameters(
            parameters: [
                "key": "RJzRdxSSJZoUmwgCyyPG",
                "secret": "ohfTefiIpsuelDjeXBgUxveQgnIOjLfO",
                "q": q,
                "page": p
            ],
          encoding: URLEncoding.default)
      }
    }
    
    var headers: [String : String]? {
        return [
            "Content-type": "application/json",
        ]
    }
}
