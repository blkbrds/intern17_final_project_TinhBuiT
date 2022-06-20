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
              let main = viewModel.mainWeather?.main,
              let tempMaxs = main.tempmax,
              let tempMins = main.tempMin,
              let temps = main.temp
        else { return }
        statusLabel.text = weather.descrip
        tempMaxLabel.text = "\(Int(tempMaxs - 273))°"
        tempLabel.text = "\(Int(temps - 273))°"
        tempMinLabel.text = "\(Int(tempMins - 273))°"
    }
}
