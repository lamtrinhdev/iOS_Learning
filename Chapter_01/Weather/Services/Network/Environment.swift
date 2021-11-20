//
//  Environment.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 20-November-2021.
//

import Foundation

// Enum for Environment
enum BuildEnvironment: String {
    case debug      = "Debug"
    case uat        = "UAT"
    case release    = "Release"
}

enum Endpoint: String {
    case daily = "/daily"
}

enum Path: String {
    case defaultPath = "/data/2.5/forecast"
}

private enum AppID: String {
    case development    = "924c96ebf8436ee1cefd7f7969476a39"
    case uat            = "6ba6a1a87ac77cf264323ee92cded8e8"
    case production     = "5757185758a4c95d71d994271052d28f"
}

// Just have only one url for both development, uat (staging), production
private enum UrlEndPoints: String {
    case development = "https://api.openweathermap.org"
}

class Environment {
    static let shared = Environment()
    var buildEnvironment: BuildEnvironment

    private init() {
        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as! String
        buildEnvironment = BuildEnvironment(rawValue: currentConfiguration)!
        Log.debug(message: "environmentConfig = \(buildEnvironment)")
    }

    var baseURL: String {
        switch buildEnvironment {
        case .debug, .uat, .release:
            return UrlEndPoints.development.rawValue
        }
    }

    func getAppID() -> String {
        switch buildEnvironment {
        case .debug:
            return AppID.development.rawValue
        case .uat:
            return AppID.uat.rawValue
        case .release:
            return AppID.production.rawValue
        }
    }

    // Get the URL for request
    func getURL(for endPoint: Endpoint, path: Path = .defaultPath) -> String {
        return baseURL + path.rawValue + endPoint.rawValue
    }
}
