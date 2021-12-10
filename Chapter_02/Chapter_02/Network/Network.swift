//
//  Network.swift
//  Chapter_02
//
//  Created by Lam Trinh Tran Truc on 06-December-2021.
//

import Foundation
import RxAlamofire
import RxSwift
import Alamofire

final class Network<T: Decodable> {
    private let scheduler: ConcurrentDispatchQueueScheduler

    init() {
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: .background, relativePriority: 1))
    }

    func searchDailyWeather(_ endPoint: Endpoint, _ queries: [String: String]) -> Observable<T> {
        var absolutePath = Environment.shared.getURL(for: .daily)
        var query = kParamKeyAppID + Environment.shared.getAPIKey()
//        let queries: [String: String] = [
//            kParamKeyCity: city,
//            kParamKeyNumberOfDays: String(kDefaultTotalDaysRequest),
//            kParamKeyUnit: kDefaultValueTempUnit
//        ]
//
        for (code, value) in queries {
            query += code + value
        }

        query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        absolutePath += query

        return RxAlamofire
            .data(.get, absolutePath)
            .debug()
            .observe(on: scheduler)
            .map({ data -> T in
                let data = try JSONDecoder().decode(T.self, from: data)
                debugPrint(data)
                return data
            })
    }
    
}
