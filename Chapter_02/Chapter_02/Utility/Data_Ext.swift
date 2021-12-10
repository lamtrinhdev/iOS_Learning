//
//  Data_Ext.swift
//  Chapter_02
//
//  Created by Lam Trinh Tran Truc on 10-December-2021.
//

import Foundation

extension Date {
    // Convert Date to String with Format
    func toString(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
