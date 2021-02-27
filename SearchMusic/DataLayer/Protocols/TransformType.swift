//
//  TransformType.swift
//  DataLayer
//
//  Created by Albert Gil Escura on 27/2/21.
//

protocol TransformType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
