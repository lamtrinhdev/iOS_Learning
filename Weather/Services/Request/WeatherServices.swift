//
//  WeatherServices.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 20-November-2021.
//

import Foundation
import Alamofire
import RxSwift

protocol WeatherService {
    func request<T: Codable>(
        url: URL,
        method: HTTPMethod,
        contentType: String,
        headers: HTTPHeaders,
        parameters: [String: Any]?,
        encoding: ParameterEncoding
    ) -> Observable<T>
}

final class WeatherWebService: WeatherService {
    func request<T>(url: URL, method: HTTPMethod, contentType: String, headers: HTTPHeaders, parameters: [String: Any]?, encoding: ParameterEncoding) -> Observable<T> where T: Decodable, T: Encodable {
        // Checking Internet Available or not.
        guard Reachability.isInternetAvailable() else {
            return Observable<T>.create({ observer -> Disposable in
                observer.onError(NetworkError.unReachable)
                return Disposables.create()
            })
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(contentType, forHTTPHeaderField: kDefaultContentTypeHTTPHeaderField)

        for (headerField, headerValue) in headers {
            urlRequest.setValue(headerValue, forHTTPHeaderField: headerField)
        }

        if let parameters = parameters {
            do {
                urlRequest = try encoding.encode(urlRequest, with: parameters)
            } catch {
                Log.debug(message: error.localizedDescription)
            }
        }

        let result = Observable<T>.create { observer -> Disposable in
            Log.debug(message: "URLRequest: \(urlRequest)")

            let request = Alamofire
                .request(urlRequest)
                .validate()
                .responseObject { (response: DataResponse<T>) in
                    Log.debug(message: "Services:\(response)")
                    if let value = response.result.value {
                        observer.onNext(value)
                    }
                    if let error = response.result.error {
                        observer.onError(error)
                    }
                    observer.on(.completed)
                }
            return Disposables.create(with: {request.cancel()})
        }

        return result
    }
}
