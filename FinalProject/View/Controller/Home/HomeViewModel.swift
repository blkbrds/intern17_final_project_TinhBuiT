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
    var weather: Weather?
    var main: Main?

    enum TypeCell: Int {
        case homeCell = 0
        case forecastCell
        case amountOfRainCell
        case detailCell
    }

    // MARK: - Functions
    func viewModelForItem(indexPath: IndexPath) -> HomeTableViewCellViewModel {
        guard let weather = weather else { return HomeTableViewCellViewModel() }
        return HomeTableViewCellViewModel(mainWeather: MainWeather(weather: [weather], main: main))
    }

    func heightcell(at indexPath: IndexPath) -> CGFloat {
        guard let type = TypeCell(rawValue: indexPath.row) else { return 0 }
        switch type {
        case .homeCell, .detailCell:
            return 200
        case .forecastCell:
            return 500
        case .amountOfRainCell:
            return 150
        }
    }

    func getDataWeather(completion: @escaping APICompletion) {
        WeatherService.getDataWeather { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.weather = data.weather?.first
                this.main = data.main
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
