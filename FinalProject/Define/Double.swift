//
//  Double.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/22/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation
import UIKit

extension Double {

    var convertAmountOfRainIcon: UIImage? {
        switch self {
        case 0...0.24:
            return #imageLiteral(resourceName: "rain_ico_0")
        case 0.25...0.5:
            return #imageLiteral(resourceName: "rain_ico_10")
        case 0.51...0.7:
            return #imageLiteral(resourceName: "rain")
        case 0.71...1:
            return #imageLiteral(resourceName: "rain_ico_70")
        default:
            return nil
        }
    }
}
