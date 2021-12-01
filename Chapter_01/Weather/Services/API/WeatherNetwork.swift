//
//  WeatherNetwork.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 30-November-2021.
//

import RxSwift

final class WeatherNetwork {
    private let network: Network<WeatherDataResponseModel>

    init(network: Network<WeatherDataResponseModel>) {
        self.network = network
    }

    func getWeatherInfo(queries: [String: String]) -> Observable<WeatherDataResponseModel> {
        network.getWeather(.daily, queries)
    }
}
