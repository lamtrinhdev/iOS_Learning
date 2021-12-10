//
//  WeatherNetwork.swift
//  Chapter_02
//
//  Created by Lam Trinh Tran Truc on 09-December-2021.
//

import RxSwift

final class WeatherNetwork {
    private let network: Network<WeatherDataResponseModel>

    init(network: Network<WeatherDataResponseModel>) {
        self.network = network
    }

    func getWeather(_ queries: [String: String]) -> Observable<WeatherDataResponseModel> {
        return network.searchDailyWeather(.daily, queries)
    }
}
