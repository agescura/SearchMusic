//
//  SearchSectionItem.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import Foundation

enum SearchSectionItem: Equatable {
    case search(viewModel: SearchViewModel)
    case message
    
    static func == (lhs: SearchSectionItem, rhs: SearchSectionItem) -> Bool {
        switch (lhs, rhs) {
            case (.search(viewModel: let lhsSearchViewModel), .search(viewModel: let rhsSearchViewModel)):
            return lhsSearchViewModel == rhsSearchViewModel
            case (.message, .message):
            return true
        default:
            return false
        }
    }
    
    var url: URL? {
        switch self {
        case .search(viewModel: let viewModel):
            return URL(string: viewModel.bottomImage)
        case .message:
            return nil
        }
    }
}
