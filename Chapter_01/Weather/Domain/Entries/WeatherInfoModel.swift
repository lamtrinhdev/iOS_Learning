//
//  WeatherInfoModel.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 19-November-2021.
//

import Foundation

struct WeatherDataResponseModel: Codable {
    let cod: DynamicValueType? // This is multiple types in a response, Double and String
    let message: DynamicValueType? // This is multiple types in a response, Success = Double, Error = String
    let city: WeatherCityModel?
    let list: [WeatherDayModel]?
}

struct WeatherCityModel: Codable {
    let id: Int?
    let name: String?
    let timezone: Int?
}

struct WeatherDayModel: Codable {
    let dt: Int?
    let temp: WeatherTemperatureModel?
}

struct WeatherTemperatureModel: Codable {
    let min: Double?
    let max: Double?
}

struct DynamicValueType: Codable {
    let value: String

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let str = try? container.decode(String.self) {
            value = str
        } else if let int = try? container.decode(Int.self) {
            value = int.description
        } else if let double = try? container.decode(Double.self) {
            value = double.description
        } else if let bool = try? container.decode(Bool.self) {
            value = bool.description
        } else {
            throw DecodingError.typeMismatch(String.self, .init(codingPath: decoder.codingPath, debugDescription: ""))
        }
    }
}

struct WeatherDataModel {
    let listDaily: [WeatherDataDailyModel]
}

struct WeatherDataDailyModel {
    let date: String?
    let averageTemp: String?
}
