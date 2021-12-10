//
//  Reusable.swift
//  Chapter_02
//
//  Created by Lam Trinh Tran Truc on 10-December-2021.
//

import UIKit

protocol Reusable {
    static var reuseID: String { get }
}

extension Reusable {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable { }
