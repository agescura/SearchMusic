//
//  SearchSectionModel.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import RxDataSources

enum SearchSectionModel: Equatable {
    case section(items: [SearchSectionItem])
}

extension SearchSectionModel: SectionModelType {
    typealias Item = SearchSectionItem
    
    var items: [SearchSectionItem] {
        switch self {
        case let .section(items: items):
            return items.map { $0 }
        }
    }

    init(original: SearchSectionModel, items: [Item]) {
        switch original {
        case .section(items: _):
            self = .section(items: items)
        }
    }
}

extension SearchSectionModel {
    static let message: [SearchSectionModel] = [SearchSectionModel.section(items: [SearchSectionItem.message])]
}
