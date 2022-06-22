//
//  ForecastCellDayModelViewModel.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/21/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class ForecastdayTableCellViewModel {

    // MARK: - Properties
    var daily: Daily?

    // MARK: - Initialize
    init(daily: Daily?) {
        self.daily = daily
    }

    // MARK: - Functions
    func UTCToDay(date: Double) -> String {
        let date = NSDate(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d"
        let nameDay = dateFormatter.string(from: date as Date)

        return nameDay
    }
}
