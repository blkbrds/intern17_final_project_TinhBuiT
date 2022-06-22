//
//  ForecastCollectionViewCell.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/15/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class ForecastCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!

    // MARK: - Properties
    var viewModel: ForecastCollectionViewCellViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Private functions
    private func updateView() {
        guard let viewModel = viewModel,
              let hourly = viewModel.hourly,
              let weather = viewModel.hourly?.weathers?.first,
              let timeUtc = viewModel.hourly?.dt
        else { return }
        timeLabel.text = viewModel.UTCToLocal(date: timeUtc)
        if let tempDouble = hourly.temp {
            setTempToLable(temp: Int(tempDouble), label: tempLabel)
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
