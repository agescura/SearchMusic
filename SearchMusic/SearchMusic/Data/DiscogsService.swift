//
//  DiscogsService.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 23/2/21.
//

import Moya

enum DiscogsService: TargetType {
    case search(album: String, page: Int)
    
    var baseURL: URL {
        URL(string: "https://api.discogs.com/database")!
    }
    
    var path: String {
        switch self {
        case .search:
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
      case .search(album: let q, page: let p):
        return .requestParameters(
            parameters: [
                "key": "RJzRdxSSJZoUmwgCyyPG",
                "secret": "ohfTefiIpsuelDjeXBgUxveQgnIOjLfO",
                "type": "master",
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
