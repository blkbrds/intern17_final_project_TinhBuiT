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
    @IBOutlet private weak var tempMaxLabel: UILabel!
    @IBOutlet private weak var tempMinLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!

    // MARK: - Properties
    var viewModel: HomeTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Private functions
    private func updateView() {
        guard let viewModel = viewModel,
              let weather = viewModel.mainWeather?.weather?.first,
              let main = viewModel.mainWeather?.main
        else { return }
        statusLabel.text = weather.descrip
        if let tempMaxDouble = main.tempmax {
            setTempToLable(temp: Int(tempMaxDouble), label: tempMaxLabel)
        }
        if let tempMinDouble = main.tempMin {
            setTempToLable(temp: Int(tempMinDouble), label: tempMinLabel)
        }
        if let tempDouble = main.temp {
            setTempToLable(temp: Int(tempDouble), label: tempLabel)
        }
    }

    private func setTempToLable(temp: Int, label: UILabel) {
        label.text = temp.convertDegreesCelsius
    }
}
