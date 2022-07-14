//
//  AmountOfRainViewModel.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/22/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class AmountOfRainViewModel {

    // MARK: - Properties
    var hourly: [Hourly]?
    var count: Int = 0

    // MARK: - Initialize
    init() { }

    init(hourly: [Hourly]?) {
        self.hourly = hourly
    }
    // MARK: - Functions
    func viewModelForAmountCollectionView(at indexPath: IndexPath) -> AmountCollectionViewCellViewModel {
        return AmountCollectionViewCellViewModel(hourly: hourly?[indexPath.row])
    }
}
