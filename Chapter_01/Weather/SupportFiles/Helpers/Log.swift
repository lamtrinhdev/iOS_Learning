//
//  Log.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 20-November-2021.
//

import Foundation

enum Log {
    static func debug(message: String) {
        #if DEBUG
        print(message)
        #endif
    }
}
