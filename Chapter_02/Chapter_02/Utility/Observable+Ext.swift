//
//  Observable+Ext.swift
//  Chapter_02
//
//  Created by Lam Trinh Tran Truc on 10-December-2021.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }
}
