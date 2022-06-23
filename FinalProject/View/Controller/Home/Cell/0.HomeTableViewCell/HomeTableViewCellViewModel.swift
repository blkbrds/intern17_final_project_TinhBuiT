//
//  HomeTableViewCellViewModel.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/10/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class HomeTableViewCellViewModel {

    // MARK: - Properties
    var mainWeather: MainWeather?

    // MARK: - Initialize
    init() {}

    init(mainWeather: MainWeather) {
        self.mainWeather = mainWeather
    }
}
