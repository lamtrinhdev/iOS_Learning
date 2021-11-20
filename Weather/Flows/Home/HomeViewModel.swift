//
//  HomeViewModel.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 19-November-2021.
//

import Foundation
import RxRelay

class HomeViewModel: BaseViewModel {
    let weatherData = BehaviorRelay<WeatherDataModel?>(value: nil)

    deinit {
        Log.debug(message: "HomeViewModel: Deinit")
    }

    // Request Weather Info with city
    func requestWeatherInfo(city: String) {
        // Init WeatherAPI
        let api = WeatherAPI(service: self.service)
        // Show Indicator and start animation
        showLoading.accept(true)

        let queries: [String: String] = [
            kParamKeyCity: city,
            kParamKeyNumberOfDays: String(kDefaultTotalDaysRequest),
            kParamKeyUnit: kDefaultValueTempUnit
        ]

        // Start request
        api.startRequestWeatherInfo(queries: queries)
            .subscribe { [weak self] data in
                guard let self = self else { return }
                self.showLoading.accept(false)
                if data.cod?.value == kAPIRequestSuccessCode {
                    let weatherData = self.createWeatherData(weatherResponseData: data)
                    self.weatherData.accept(weatherData)
                } else {
                    let errorMessage = self.getErrorMessage(errorMessage: data.message?.value, errorCode: data.cod?.value)
                    self.errorData.accept(errorMessage)
                }
            } onError: { [weak self] error in
                guard let self = self else { return }
                self.showLoading.accept(false)
                if let error = error as? ServerReponseError<ErrorModel>, let erroMessage = error.data?.message?.value {
                    self.errorData.accept(erroMessage)
                } else {
                    self.errorData.accept(error.localizedDescription)
                }
            } onCompleted: {
                Log.debug(message: "HomeViewModel startRequestWeatherInfo: Completed")
            }
            .disposed(by: disposeBag)
    }

    private func createWeatherData(weatherResponseData: WeatherDataResponseModel) -> WeatherDataModel {
        var listDaily: [WeatherDataDailyModel] = []

        for dailyElement in (weatherResponseData.list ?? []) {
            let date = getDateStringFromTimeInterval(
                timeIntervalSince1970: dailyElement.dt,
                dateFormat: DateFormat.yyyyMMdd.rawValue
            )

            let averageTemperature = self.getAverageTemperature(maxTemp: dailyElement.temp?.max, minTemp: dailyElement.temp?.min)

            listDaily.append(WeatherDataDailyModel(date: date, averageTemp: averageTemperature))
        }

        return WeatherDataModel(listDaily: listDaily)
    }

    private func getDateStringFromTimeInterval(timeIntervalSince1970: Int?, dateFormat: String) -> String {
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

    private func getAverageTemperature(maxTemp: Double?, minTemp: Double?) -> String {
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
