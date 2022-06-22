//
//  ForecastCellViewModel.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/21/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class ForecastCellViewModel {

    // MARK: - Properties
    var hourly: [Hourly]?
    var daily: [Daily]?
    var mainApi: MainApi?

    // MARK: - Initialize
    init() { }

    init(hourly: [Hourly]?, daily: [Daily]?) {
        self.hourly = hourly
        self.daily = daily
    }

    // MARK: - Functions
    func viewModelForCollectin(at indexPath: IndexPath) -> ForecastCollectionViewCellViewModel {
        return ForecastCollectionViewCellViewModel(hourly: hourly?[indexPath.row])
    }

    func viewModelForForecastDayTableCell(at indexPath: IndexPath) -> ForecastdayTableCellViewModel {
        return ForecastdayTableCellViewModel(daily: daily?[indexPath.row])
    }
}
