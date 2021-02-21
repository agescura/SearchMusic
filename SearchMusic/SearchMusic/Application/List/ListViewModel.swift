//
//  ListViewModel.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import RxSwift

struct ListViewModel {
    
    let albums: Observable<[Album]> = .just([
        Album(title: "London Calling", genre: "Rock", country: "UK", year: "1990"),
        Album(title: "Ok Computer", genre: "Alternative", country: "UK", year: "1997"),
        Album(title: "Hunky Dory", genre: "Rock", country: "UK", year: "1983"),
        Album(title: "Fear of Music", genre: "Heavy Metal", country: "UK", year: "1979")
    ])
}
