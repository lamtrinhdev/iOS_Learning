//
//  BaseViewModel.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 19-November-2021.
//

import Foundation

import Alamofire
import RxSwift
import RxRelay

class BaseViewModel {
    let errorData = BehaviorRelay<String?>(value: nil)
    let showLoading = BehaviorRelay<Bool?>(value: nil)
    let service: WeatherService
    let disposeBag = DisposeBag()

    init(service: WeatherService? = nil) {
        self.service = service ?? WeatherWebService()
    }

    // Get the error Message.
    func getErrorMessage(errorMessage: String?, errorCode: String?) -> String {
        // If the errorMessage existing, return errorMessage.
        if let errorMessage = errorMessage {
            return errorMessage
        }
        // If the errorMessage is not existing, return the errorCode if it is existing.
        else if let errorCode = errorCode {
            return String(
                format: NSLocalizedString("kAPIRequestResponseWithErrorCode", comment: "Show Error with Code"),
                errorCode)
        }
        // Return the Unknow error if both errorMessage and errorCode they are not existing.
        else {
            return NSLocalizedString("kAPIRequestResponseUnknownError", comment: "Show Error with Code")
        }
    }
}
