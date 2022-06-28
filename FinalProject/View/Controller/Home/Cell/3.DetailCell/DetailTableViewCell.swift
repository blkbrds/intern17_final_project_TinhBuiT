//
//  DetailTableViewCell.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/17/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class DetailTableViewCell: UITableViewCell {

    // MARK: IBoutlets
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var tempMaxLabel: UILabel!
    @IBOutlet private weak var humiditylabel: UILabel!
    @IBOutlet private weak var tempMinlabel: UILabel!
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
        if let tempMaxDouble = daily.temp?.max {
            setTempToLable(temp: Int(tempMaxDouble), label: tempMaxLabel)
        }
        if let humidityInt = daily.humidity {
            humiditylabel.text = "\(humidityInt)%"
        }
        if let tempMinDouble = daily.temp?.min {
          setTempToLable(temp: Int(tempMinDouble), label: tempMinlabel)
        }
        if let uvDoubel = daily.uvIndex {
            uvIndexLabel.text = "\(uvDoubel)"
        }
    }

    private func setIconToImage(icon: String, images: UIImageView) {
       images.image = icon.convertWeatherIcon
    }
    private func setTempToLable(temp: Int, label: UILabel) {
        label.text = temp.convertDegreesCelsius
    }
}
