//
//  UITableView+RxDataSources.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import RxSwift

extension Reactive where Base: UITableView {
    
    public func items<Sequence: Swift.Sequence, Cell: UITableViewCell, Source: ObservableType>
        (_ cellType: Cell.Type = Cell.self)
        -> (_ source: Source)
        -> (_ configureCell: @escaping (Int, Sequence.Element, Cell) -> Void)
        -> Disposable
    where Source.Element == Sequence {
        items(cellIdentifier: String(describing: cellType), cellType: cellType)
    }
}
