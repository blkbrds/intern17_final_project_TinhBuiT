//
//  WindPresureTableViewCellViewModel.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/23/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class WindPresureTableViewCellViewModel {

    // MARK: - Properties
    var mainApi: MainApi?

    // MARK: - Initialize
    init() {}

    init(mainApi: MainApi) {
        self.mainApi = mainApi
    }
}
