//
//  SearchUseCase.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import RxSwift

protocol SearchUseCaseProtocol {
    var albums: Observable<[Album]> { get }
}

class SearchUseCase: SearchUseCaseProtocol {
    
    let albums: Observable<[Album]> = Observable<Int>.timer(.seconds(0),
                                                            period: .seconds(1),
                                                            scheduler: MainScheduler.instance)
        .flatMap { timer -> Observable<[Album]> in
            if timer != 10 {
                return .just([
                        Album(title: "London Calling", genre: "Rock", country: "UK", year: "1990"),
                        Album(title: "Ok Computer", genre: "Alternative", country: "UK", year: "1997"),
                        Album(title: "Hunky Dory", genre: "Rock", country: "UK", year: "1983"),
                        Album(title: "Fear of Music", genre: "Heavy Metal", country: "UK", year: "1979")
                ].shuffled())
            }
            return .error(ApplicationError.unknown)
        }
}
