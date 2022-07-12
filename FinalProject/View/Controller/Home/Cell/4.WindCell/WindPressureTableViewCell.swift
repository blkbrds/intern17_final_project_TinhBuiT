//
//  WindPressureTableViewCell.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/16/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class WindPressureTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var windmillImage: UIImageView!
    @IBOutlet private weak var windLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!

    // MARK: - Properties
    var viewModel: WindPresureTableViewCellViewModel? {
        didSet {
            updateView()
            rotating()
        }
    }

    // MARK: - Private funtions
    private func updateView() {
        guard let viewModel = viewModel,
              let daily = viewModel.mainApi?.daily?.first
        else { return }
        if let pressureInt = daily.pressure {
            pressureLabel.text = "\(pressureInt)hPa"
        }
        if let windDoble = daily.wind {
            windLabel.text = "\(windDoble)m/s"
        }
    }

    func rotating() {
        self.windmillImage.rotate()
    }
}

extension UIView {
    func rotate() {
       let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 5
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
