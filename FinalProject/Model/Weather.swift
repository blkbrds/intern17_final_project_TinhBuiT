//
//  Weather.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/9/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class Weather {

    // MARK: - Properties
    var main: String?
    var descrip: String?
    var icon: String?

    // MARK: - Initialize
    init(json: JSON) {
        self.main = json["main"] as? String
        self.descrip = json["description"] as? String
        self.icon = json["icon"] as? String
    }
}

final class Main {

    // MARK: - Properties
    var temp: Double?
    var tempmax: Double?
    var tempMin: Double?

    // MARK: - Initialize
    init(json: JSON) {
        self.temp = json["temp"] as? Double
        self.tempmax = json["temp_max"] as? Double
        self.tempMin = json["temp_min"] as? Double
    }
}

final class MainWeather {

    // MARK: - Properties
    var weather: [Weather]?
    var main: Main?

    // MARK: - Initialize
    init(weather: [Weather]?, main: Main?) {
        self.main = main
        self.weather = weather
    }
}
