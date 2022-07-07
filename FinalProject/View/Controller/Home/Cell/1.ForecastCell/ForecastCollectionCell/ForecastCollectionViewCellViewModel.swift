//
//  ForecastCollectionViewCellViewModel.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/21/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class ForecastCollectionViewCellViewModel {

    // MARK: - Properties
    var hourly: Hourly?

    // MARK: - Initialize
    init(hourly: Hourly?) {
        self.hourly = hourly
    }

    // MARK: - Functions
    func UTCToLocal(date: Double) -> String {
        let date = NSDate(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let nameDay = dateFormatter.string(from: date as Date)

        return nameDay
    }
}
