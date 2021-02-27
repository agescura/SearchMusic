//
//  ListSectionModel.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import RxDataSources
import DomainLayer

enum ListSectionModel: Equatable {
    case section(items: [ListSectionItem])
}

extension ListSectionModel: SectionModelType {
    typealias Item = ListSectionItem
    
    var items: [ListSectionItem] {
        switch self {
        case let .section(items: items):
            return items.map { $0 }
        }
    }

    init(original: ListSectionModel, items: [Item]) {
        switch original {
        case .section(items: _):
            self = .section(items: items)
        }
    }
}

extension ListSectionModel {
    static let message: [ListSectionModel] = [ListSectionModel.section(items: [ListSectionItem.message])]
}

extension Array where Element == ListSectionModel {
    init(with albums: [Album]) {
        self = albums.isEmpty ? [] :
            [ListSectionModel.section(items: albums.map { ListSectionItem.search(viewModel: $0)})]
    }
}
