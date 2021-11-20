//
//  WeatherAPI.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 20-November-2021.
//

import RxSwift
import Alamofire

class WeatherAPI: BaseAPI {
    let service: WeatherService

    init(service: WeatherService) {
        self.service = service
    }

    func startRequestWeatherInfo(queries: [String: String]) -> Observable<WeatherDataResponseModel> {
        // Get the URLString
        var urlString = Environment.shared.getURL(for: .daily)
        // Get the AppID query
        var query = kParamKeyAppID + Environment.shared.getAppID()
        for (code, value) in queries {
            query += code + value
        }

        query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        urlString += query

        let url = URL(string: urlString)!
        let result: Observable<WeatherDataResponseModel> = service.request(
            url: url,
            method: .get,
            contentType: kDefaultContentTypeValue,
            headers: [:],
            parameters: nil,
            encoding: JSONEncoding.default)

        return result
    }
}
