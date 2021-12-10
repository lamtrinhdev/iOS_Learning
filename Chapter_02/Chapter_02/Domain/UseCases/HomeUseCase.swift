//
//  HomeUseCase.swift
//  Chapter_02
//
//  Created by Lam Trinh Tran Truc on 04-December-2021.
//

import Foundation
import RxSwift

//protocol HomeUseCase {
//    func searchWeather(with city: String) -> Observable<WeatherDataResponseModel>
//}

final class HomeUseCase {
    private let network: WeatherNetwork

    init(network: WeatherNetwork) {
        self.network = network
    }

    func searchWeather(with city: String) -> Observable<WeatherDataResponseModel> {
        debugPrint("city = \(city)")
        let queries = self.getSearchWeatherQueries(with: city)
        return self.network.getWeather(queries)
    }

    func getSearchWeatherQueries(with city: String) -> [String: String] {
        let queries: [String: String] = [
            kParamKeyCity: city,
            kParamKeyNumberOfDays: String(kDefaultTotalDaysRequest),
            kParamKeyUnit: kDefaultValueTempUnit
        ]

        return queries
    }
}
