//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/9/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation
import UIKit

final class HomeViewModel {

    // MARK: - Properties
    var hourly: [Hourly]?
    var mainWeather: MainWeather?
    var mainApi: MainApi?
    var daily: [Daily]?

    enum TypeCell: Int {
        case homeCell = 0
        case forecastCell
        case amountOfRainCell
        case detailCell
    }

    // MARK: - Functions
    func viewModelForHomeCell(indexPath: IndexPath) -> HomeTableViewCellViewModel {
        guard let mainWeather = mainWeather else { return HomeTableViewCellViewModel() }
        return HomeTableViewCellViewModel(mainWeather: mainWeather)
    }

    func viewModelForForecastCell(indexPath: IndexPath) -> ForecastCellViewModel {
     guard let mainApi = mainApi else { return ForecastCellViewModel() }
        return ForecastCellViewModel(hourly: mainApi.hourly, daily: mainApi.daily)
    }

    func heightcell(at indexPath: IndexPath) -> CGFloat {
        guard let type = TypeCell(rawValue: indexPath.row) else { return 0 }
        switch type {
        case .homeCell, .detailCell:
            return 200
        case .forecastCell:
            return 530
        case .amountOfRainCell:
            return 150
        }
    }

    func getDataWeather(completion: @escaping APICompletion) {
        WeatherService.getDataWeather { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let mainWeather):
                this.mainWeather = mainWeather
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getDataMain(completion: @escaping APICompletion) {
        WeatherService.getDataMainApi { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.mainApi = data
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
