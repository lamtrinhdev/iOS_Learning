//
//  ViewModelType.swift
//  Chapter_02
//
//  Created by Lam Trinh Tran Truc on 03-December-2021.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
