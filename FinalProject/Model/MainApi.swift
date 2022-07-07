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
    var minutely: [Minutely]?
    var current: Current?
    var lat: Double?
    var lon: Double?

    // MARK: - Initialize
    init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        daily <- map["daily"]
        hourly <- map["hourly"]
        minutely <- map["minutely"]
        current <- map["current"]
        lat <- map["lat"]
        lon <- map["lon"]
    }
}

final class Minutely: Mappable {

    // MARK: - Properties
    var dt: Double?

    // MARK: - Initialize
    init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        dt <- map["dt"]
    }
}

final class Current: Mappable {

    // MARK: - Properties
    var temp: Double?
    var feelsLike: Double?
    var weather: [Weather]?

    init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        temp <- map["temp"]
        feelsLike <- map["feels_like"]
        weather <- map["weather"]
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
    var sunrise: Double?
    var sunset: Double?

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
        sunset <- map["sunset"]
        sunrise <- map["sunrise"]
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

final class Weather: Mappable {

    // MARK: - Properties
    var main: String?
    var descrip: String?
    var icon: String?

    init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        main <- map["main"]
        descrip <- map["description"]
        icon <- map["icon"]
    }
}
