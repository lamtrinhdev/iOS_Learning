//
//  UseCaseProvider.swift
//  Chapter_02
//
//  Created by Lam Trinh Tran Truc on 10-December-2021.
//

import Foundation

//protocol UseCaseProvider {
//    func makeHomeUseCase() -> HomeUseCase
//}

final class UseCaseProvider {
    func makeHomeUseCase() -> HomeUseCase {
        let network = WeatherNetwork(network: Network<WeatherDataResponseModel>())
        return HomeUseCase(network: network)
    }
}
