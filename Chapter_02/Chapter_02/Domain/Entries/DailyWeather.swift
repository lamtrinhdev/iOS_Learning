//
//  DailyWeather.swift
//  Chapter_02
//
//  Created by Lam Trinh Tran Truc on 09-December-2021.
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

    init(with weather: WeatherDataResponseModel) {
        self.listDaily = WeatherDataModel.getDailyData(with: weather)
    }

    static private func getDailyData(with weather: WeatherDataResponseModel) -> [WeatherDataDailyModel] {
        var listDaily: [WeatherDataDailyModel] = []

        for dailyElement in (weather.list ?? []) {
            let date = getDateStringFromTimeInterval(
                timeIntervalSince1970: dailyElement.dt,
                dateFormat: DateFormat.yyyyMMdd.rawValue
            )

            let averageTemperature = self.getAverageTemperature(maxTemp: dailyElement.temp?.max, minTemp: dailyElement.temp?.min)

            listDaily.append(WeatherDataDailyModel(date: date, averageTemp: averageTemperature))
        }

        return listDaily
    }

    static private func getDateStringFromTimeInterval(timeIntervalSince1970: Int?, dateFormat: String) -> String {
        // Check date value
        guard let time = timeIntervalSince1970 else {
            // Return N/A for Date
            return NSLocalizedString("kWeatherInfoNotAvailable", comment: "N/A")
        }

        // Get convert to Date from TimeInterval
        let date = Date(timeIntervalSince1970: TimeInterval(time))

        // Convert to String with format
        let dateString = date.toString(withFormat: dateFormat)

        return String(format: "%@", dateString)
    }

    static private func getAverageTemperature(maxTemp: Double?, minTemp: Double?) -> String {
        // Check maxTemp and minTemp value before calculate Average Temperature
        guard let max = maxTemp, let min = minTemp else {
            // Return N/A for Average Temperature
            return NSLocalizedString("kWeatherInfoNotAvailable", comment: "N/A")
        }

        // Calculate Average Temperature and return value
        let averageTemp = String((Int(max) + Int(min)) / 2)

        return String(
            format: NSLocalizedString("kWeatherInfoAverageTemperature", comment: "Average Temperature"),
            averageTemp)
    }
}

struct WeatherDataDailyModel {
    let date: String?
    let averageTemp: String?
}
