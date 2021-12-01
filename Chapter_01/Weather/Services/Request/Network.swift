//
//  Network.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 30-November-2021.
//

import Foundation
import RxAlamofire
import RxSwift

final class Network<T: Decodable> {
    private let scheduler: ConcurrentDispatchQueueScheduler

    init() {
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }

    func getWeather(_ endPoint: Endpoint, _ queries: [String: String]) -> Observable<T> {
        // Get the URLString
        var urlString = Environment.shared.getURL(for: endPoint)
        // Get the AppID query
        var query = kParamKeyAppID + Environment.shared.getAppID()
        for (code, value) in queries {
            query += code + value
        }

        query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        urlString += query

        return RxAlamofire
            .data(.get, urlString)
            .debug()
            .observe(on: scheduler)
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
}


