//
//  ListTableViewCell+Rx.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import RxSwift
import RxCocoa

extension Reactive where Base: ListTableViewCell {
    var viewModel: Binder<Album> {
        return Binder(base) { view, value in
            view.viewModel = value
        }
    }
}
