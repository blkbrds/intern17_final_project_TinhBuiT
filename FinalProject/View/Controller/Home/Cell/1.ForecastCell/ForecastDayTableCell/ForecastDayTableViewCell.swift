//
//  ForecastDayTableViewCell.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/15/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class ForecastDayTableViewCell: UITableViewCell {

    // MARK: - IBoutlet
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var tempMaxLabel: UILabel!
    @IBOutlet private weak var tempMinLabel: UILabel!

    // MARK: - Properties
    var viewModel: ForecastdayTableCellViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Private functions
    private func updateView() {
        guard let viewModel = viewModel,
              let daily = viewModel.daily?.temp,
              let weather = viewModel.daily?.weather?.first,
              let timeUtc = viewModel.daily?.dt
        else { return }
        dayLabel.text = viewModel.UTCToDay(date: timeUtc)
        if let tempMaxDouble = daily.max {
            setTempToLable(temp: Int(tempMaxDouble), label: tempMaxLabel)
        }
        if let tempMinDouble = daily.min {
            setTempToLable(temp: Int(tempMinDouble), label: tempMinLabel)
        }
        if let icon = weather.icon {
            setIconToImage(icon: icon, images: iconImage)
        }
    }

    private func setTempToLable(temp: Int, label: UILabel) {
        label.text = temp.convertDegreesCelsius
    }

    private func setIconToImage(icon: String, images: UIImageView) {
       images.image = icon.convertWeatherIcon
    }
}
