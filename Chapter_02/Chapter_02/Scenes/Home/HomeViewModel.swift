//
//  HomeViewModel.swift
//  Chapter_02
//
//  Created by Lam Trinh Tran Truc on 03-December-2021.
//

import Foundation
import RxCocoa

final class HomeViewModel: ViewModelType {
    struct Input {
        let searchWeather: Driver<Void>
        let city: Driver<String>
    }

    struct Output {
        let weather: Driver<[WeatherDataDailyModel]>
    }

    private let useCase: HomeUseCase

    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }

    func transform(input: Input) -> Output {
        let weather = input.searchWeather.withLatestFrom(input.city)
            .flatMapLatest {
                return self.useCase.searchWeather(with: $0)
                    .asDriverOnErrorJustComplete()
                    .map { WeatherDataModel(with: $0).listDaily
                    }
            }

        return Output(weather: weather)
    }
}
