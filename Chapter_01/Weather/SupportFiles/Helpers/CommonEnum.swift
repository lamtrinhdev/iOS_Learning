//
//  CommonEnum.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 20-November-2021.
//

import Foundation

enum WeatherInfoDataWithIndex: Int {
    case date = 0
    case averageTemperature
}

enum TableViewCellIdentifiers: String {
    case weatherInfoTableViewCellIdentifier
}

enum DateFormat: String {
    case yyyyMMdd = "yyyy-MM-dd"
}

enum NetworkError: Error {
    case unReachable
}
