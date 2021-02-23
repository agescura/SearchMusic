//
//  ObservableType.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 23/2/21.
//

import RxSwift

extension ObservableType {
    
    public func map<T: Codable>(_ type: T.Type) -> Observable<T> {
        return flatMap { data -> Observable<T> in
            guard let jsonData = data as? Data else {
                throw NSError(
                    domain: "",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Could not decode object"]
                )
            }
            
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: jsonData)
            
            return .just(object)
        }
    }
    
    public func map<T: Codable>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { data -> Observable<[T]> in
            guard let jsonData = data as? Data else {
                throw NSError(
                    domain: "",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Could not decode object"]
                )
            }
            
            let decoder = JSONDecoder()
            let objects = try decoder.decode([T].self, from: jsonData)
            
            return .just(objects)
        }
    }
}
