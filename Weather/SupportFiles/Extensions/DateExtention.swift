//
//  DateExtention.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 20-November-2021.
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
