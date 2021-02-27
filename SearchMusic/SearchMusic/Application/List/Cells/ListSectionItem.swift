//
//  ListSectionItem.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import Foundation
import DomainLayer

enum ListSectionItem: Equatable {
    case search(viewModel: Album)
    case message
    
    static func == (lhs: ListSectionItem, rhs: ListSectionItem) -> Bool {
        switch (lhs, rhs) {
            case (.search(viewModel: let lhsAlbum), .search(viewModel: let rhsAlbum)):
            return lhsAlbum == rhsAlbum
            case (.message, .message):
            return true
        default:
            return false
        }
    }
}
