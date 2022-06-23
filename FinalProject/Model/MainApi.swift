//
//  MainApi.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/21/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation
import ObjectMapper

final class MainApi: Mappable {

    // MARK: - Properties
    var daily: [Daily]?
    var hourly: [Hourly]?

    // MARK: - Initialize
    init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        daily <- map["daily"]
        hourly <- map["hourly"]
    }
}

final class Hourly: Mappable {

    // MARK: - Properties
    var dt: Double?
    var temp: Double?
    var weathers: [Weather]?
    var pop: Double?

    // MARK: - Initialize
    init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        dt <- map["dt"]
        temp <- map["temp"]
        weathers <- map["weather"]
        pop <- map["pop"]
    }
}

final class Daily: Mappable {

    // MARK: - Properties
    var dt: Double?
    var temp: Temp?
    var weather: [Weather]?
    var pressure: Int?
    var humidity: Int?
    var wind: Double?
    var uvIndex: Double?

    // MARK: - Initialize
    init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        dt <- map["dt"]
        temp <- map["temp"]
        weather <- map["weather"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        wind <- map["wind_speed"]
        uvIndex <- map["uvi"]
    }
}

final class Temp: Mappable {

    // MARK: - Properties
    var max: Double?
    var min: Double?

    // MARK: - Initialize
    init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        max <- map["max"]
        min <- map["min"]
    }
}