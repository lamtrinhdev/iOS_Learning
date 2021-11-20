//
//  DataRequestExtention.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 20-November-2021.
//

import Foundation
import Alamofire
import RxSwift

extension DataRequest {
    /**
    Serilize the json rescived from the network to the object represented by the function genaric type.
    The genaric type must comfirm to Serializable Protocol

    - returns: The serialized object if the serialization was successful. Otherwise, returns an Error.
    */
    public static func objectMapperSeriallizer<T: Decodable>() -> DataResponseSerializer<T> {
        let result: DataResponseSerializer<T> = DataResponseSerializer { (_, response, data, error) in
            if let error = error {
                if let data = data, let dataError = try? JSONDecoder().decode(ErrorModel.self, from: data) {
                    let myError = ServerReponseError(error: error, data: dataError)
                    return .failure(myError)
                }
                return .failure(error)
            }
            guard let unwrapped = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength))
            }

            do {
                let parsedObject = try JSONDecoder().decode(T.self, from: unwrapped)
                return .success(parsedObject)
            } catch {
                if let data = try? JSONSerialization.jsonObject(with: unwrapped, options: .allowFragments) as? [String: Any] {
                    let myError = ServerReponseError(error: error, data: data)
                    return .failure(myError)                }
                if let statusCode = response?.statusCode, statusCode != 200 {
                    let myError = ServerReponseError(error: error, data: statusCode)
                    return .failure(myError)
                }
                return .failure(error)
            }
        }
        return result
    }

    /**
    Adds a handler to be called once the request has finished.

    - parameter queue:             The queue on which the completion handler is dispatched.
    - parameter keyPath:           The key path where object mapping should be performed
    - parameter object:            An object to perform the mapping on to
    - parameter completionHandler: A closure to be executed once the request has finished and the data has been mapped by ObjectMapper.

    - returns: The request.
    */
    @discardableResult
    public func responseObject<T: Decodable>(queue: DispatchQueue? = nil, keyPath _ : String? = nil, completionHandler: @escaping((DataResponse<T>) -> Void)) -> Self {
        return response(
            queue: queue,
            responseSerializer: DataRequest.objectMapperSeriallizer(),
            completionHandler: completionHandler)
    }
}
