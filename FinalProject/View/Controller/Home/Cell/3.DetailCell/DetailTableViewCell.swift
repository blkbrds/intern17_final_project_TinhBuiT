//
//  DetailTableViewCell.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/17/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class DetailTableViewCell: UITableViewCell {

    // MARK: Private functions
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humiditylabel: UILabel!
    @IBOutlet private weak var windLabel: UILabel!
    @IBOutlet private weak var uvIndexLabel: UILabel!

    // MARK: - Properties
    var viewModel: DetailTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Private functions
    private func updateView() {
        guard let viewModel = viewModel,
              let daily = viewModel.mainApi?.daily?.first,
              let weather = viewModel.mainApi?.daily?.first?.weather?.first
        else { return }
        if let icon = weather.icon {
            setIconToImage(icon: icon, images: iconImage)
        }
        if let pressInt = daily.pressure {
            pressureLabel.text = "\(pressInt)hPa"
        }
        if let humidityInt = daily.humidity {
            humiditylabel.text = "\(humidityInt)%"
        }
        if let windDouble = daily.wind {
            windLabel.text = "\(windDouble)m/s"
        }
        if let uvDoubel = daily.uvIndex {
            uvIndexLabel.text = "\(uvDoubel)"
        }
    }

    private func setIconToImage(icon: String, images: UIImageView) {
       images.image = icon.convertWeatherIcon
    }
}
