//
//  Environment.swift
//  Chapter_02
//
//  Created by Lam Trinh Tran Truc on 06-December-2021.
//

import Foundation

enum Endpoint: String {
    case daily = "/daily"
}

enum Path: String {
    case defaultPath = "/data/2.5/forecast"
}

private enum APIKey: String {
    case defaultKey    = "924c96ebf8436ee1cefd7f7969476a39"
}

private enum BaseURL: String {
    case defaultURL = "https://api.openweathermap.org"
}

final class Environment {
    static let shared = Environment()
    private init() { }

    func getAPIKey() -> String {
        return APIKey.defaultKey.rawValue
    }

    func getURL(for endPoint: Endpoint, path: Path = .defaultPath) -> String {
        return BaseURL.defaultURL.rawValue + path.rawValue + endPoint.rawValue
    }
}
