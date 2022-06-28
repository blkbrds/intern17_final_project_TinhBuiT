//
//  SunTableViewCellViewModel.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/23/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class SunTableViewCellViewModel {

    // MARK: - Properties
    var mainApi: MainApi?

    // MARK: - Initialize
    init() {}

    init(mainApi: MainApi) {
        self.mainApi = mainApi
    }

    // MARK: - Functions
    func utcToHour(date: Double) -> String {
        let date = NSDate(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let nameDay = dateFormatter.string(from: date as Date)
        return nameDay
    }
}
