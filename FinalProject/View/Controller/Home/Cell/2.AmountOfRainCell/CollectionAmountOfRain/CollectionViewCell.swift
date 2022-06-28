//
//  CollectionViewCell.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/22/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var popLabel: UILabel!
    @IBOutlet private weak var imageLabel: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!

    // MARK: - Properties
    var viewModel: AmountCollectionViewCellViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Private functions
    private func updateView() {
        guard let viewModel = viewModel,
              let hourly = viewModel.hourly,
              let timeUtc = viewModel.hourly?.dt
        else { return }
        timeLabel.text = viewModel.utcToHour(date: timeUtc)
        if let popDouble = hourly.pop {
            popLabel.text = "\(Int(popDouble * 100))%"
            setIconFromPop(pop: popDouble, images: imageLabel)
        }
    }

    private func setIconFromPop(pop: Double, images: UIImageView) {
        images.image = pop.convertAmountOfRainIcon
    }

    private func setNamefromTime(time: String, label: UILabel) {
        label.text = time.convertTime
    }
}
