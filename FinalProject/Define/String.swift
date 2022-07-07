//
//  App.swift
//  FinalProject
//
//  Created by Bien Le Q. on 8/26/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//
import Foundation
import UIKit

extension  String {

    func capitalizingFirstLetter() -> String {
          return prefix(1).capitalized + dropFirst()
      }

    var convertWeatherIcon: UIImage? {
        switch self {
        case "01d":
            return #imageLiteral(resourceName: "01d")
        case "01n":
            return #imageLiteral(resourceName: "01n")
        case "02d":
            return #imageLiteral(resourceName: "02d")
        case "02n":
            return #imageLiteral(resourceName: "02n")
        case "03d", "03n":
            return #imageLiteral(resourceName: "03d")
        case "04n", "04d":
            return #imageLiteral(resourceName: "04d")
        case "09d", "09n":
            return #imageLiteral(resourceName: "09d")
        case "10d":
            return #imageLiteral(resourceName: "10d")
        case "10n":
            return #imageLiteral(resourceName: "09d")
        case "11d", "11n":
            return #imageLiteral(resourceName: "11d")
        case "13d", "13n":
            return #imageLiteral(resourceName: "13d")
        case "50n", "50d":
            return #imageLiteral(resourceName: "50d")
        default:
            return nil
        }
    }

    var convertTime: String {
        switch self {
        case  "04", "05", "06", "07", "08", "09":
            return "sang"
        case  "10", "11", "12", "13", "14", "15":
            return "trua"
        case "16", "17", "18", "19", "20", "21":
            return "toi"
        case "22", "23", "00", "01", "02", "03":
            return "dem"
        default:
            return "oh"
        }
    }
}
