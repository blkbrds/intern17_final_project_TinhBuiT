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
    private let screenWidth = UIScreen.main.bounds.width

    enum TypeCell: Int {
        case homeCell = 0
        case forecastCell
        case amountOfRainCell
        case detailCell
        case windCell
        case sunCell
        case mapCell
    }

    // MARK: - Functions
    func viewModelForHomeCell(indexPath: IndexPath) -> HomeTableViewCellViewModel {
        guard let mainApi = mainApi else { return HomeTableViewCellViewModel() }
        return HomeTableViewCellViewModel(mainApi: mainApi)
    }

    func viewModelForForecastCell(indexPath: IndexPath) -> ForecastCellViewModel {
     guard let mainApi = mainApi else { return ForecastCellViewModel() }
        return ForecastCellViewModel(hourly: mainApi.hourly, daily: mainApi.daily)
    }

    func viewModelForDetailCell(indexPath: IndexPath) -> DetailTableViewCellViewModel {
        guard let mainApi = mainApi else { return DetailTableViewCellViewModel() }
        return DetailTableViewCellViewModel(mainApi: mainApi)
    }

    func viewModelForAmountOfRainCell(indexPath: IndexPath) -> AmountOfRainViewModel {
        guard let mainApi = mainApi else { return AmountOfRainViewModel() }
        return AmountOfRainViewModel(hourly: mainApi.hourly)
    }

    func viewModelForWindPresureCell(indexPath: IndexPath) -> WindPresureTableViewCellViewModel {
        guard let mainApi = mainApi else { return WindPresureTableViewCellViewModel() }
        return WindPresureTableViewCellViewModel(mainApi: mainApi)
    }

    func viewModelForSunCell(indexPath: IndexPath) -> SunTableViewCellViewModel {
        guard let mainApi = mainApi else { return SunTableViewCellViewModel() }
        return SunTableViewCellViewModel(mainApi: mainApi)
    }

    func viewModelForMapCell(indexPath: IndexPath) -> MapTableViewcellViewModel {
        guard let mainApi = mainApi else { return MapTableViewcellViewModel() }
        return MapTableViewcellViewModel(mainApi: mainApi)
    }

    func heightcell(at indexPath: IndexPath) -> CGFloat {
        guard let type = TypeCell(rawValue: indexPath.row) else { return 0 }
        switch type {
        case .homeCell, .detailCell:
            return 200
        case .forecastCell:
            return 530
        case .amountOfRainCell:
            return 180
        case .windCell:
            return 180
        case .sunCell:
            return screenWidth / 2 + 100
        case .mapCell:
            return 300
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
        WeatherService.getDataMainApi(lat: 16.054407) { [weak self] result in
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
