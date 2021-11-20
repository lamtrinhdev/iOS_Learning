//
//  ErrorModel.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 19-November-2021.
//

import Foundation

struct ServerReponseError<T>: Error {
    let error: Error
    let data: T?
}

struct ErrorModel: Codable {
    let cod: DynamicValueType? // This is multiple types in a response, Double and String
    let message: DynamicValueType? // This is multiple types in a response, Success = Double, Error = String
}
