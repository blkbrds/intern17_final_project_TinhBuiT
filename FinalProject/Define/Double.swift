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
        if self < 25 {
            return #imageLiteral(resourceName: "rain_ico_0")
        } else if self < 50 {
            return #imageLiteral(resourceName: "rain_ico_10")
        } else if self < 100 {
            return #imageLiteral(resourceName: "rain")
        }
        return nil
    }
}
