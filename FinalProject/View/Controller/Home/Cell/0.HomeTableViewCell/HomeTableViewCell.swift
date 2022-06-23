//
//  HomeTableViewCell.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/9/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!

    // MARK: - Properties
    var viewModel: HomeTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Private functions
    private func updateView() {
        guard let viewModel = viewModel,
              let weather = viewModel.mainWeather?.weather?.first,
              let main = viewModel.mainWeather?.main
        else { return }
        if let status = weather.descrip {
            setUpCaseLabel(title: status, label: statusLabel)
        }
        if let tempFeelsLikeDouble = main.feelLike {
            setTempToLable(temp: Int(tempFeelsLikeDouble), label: feelsLikeLabel)
        }
        if let tempDouble = main.temp {
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
    private func setUpCaseLabel(title: String, label: UILabel) {
        label.text = title.capitalizingFirstLetter()
    }
}
