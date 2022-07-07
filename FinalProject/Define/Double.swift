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
        case 0...0.2:
            return #imageLiteral(resourceName: "rain_ico_0")
        case 0.2...0.4:
            return #imageLiteral(resourceName: "rain_ico_10")
        case 0.4...0.6:
            return #imageLiteral(resourceName: "rain")
        case 0.6...0.8:
            return #imageLiteral(resourceName: "rain_ico_70")
        case 0.8...1:
            return #imageLiteral(resourceName: "rain_ico_100")
        default:
            return nil
        }
    }
}
