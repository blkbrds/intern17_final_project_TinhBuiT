//
//  Weather.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/9/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation
import ObjectMapper

final class MainWeather: Mappable {

    // MARK: - Properties
    var weather: [Weather]?
    var main: Main?

    init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        main <- map["main"]
        weather <- map["weather"]
    }
}

//final class Weather: Mappable {
//
//    // MARK: - Properties
//    var main: String?
//    var descrip: String?
//    var icon: String?
//
//    init?(map: Map) {
//        mapping(map: map)
//    }
//
//    func mapping(map: Map) {
//        main <- map["main"]
//        descrip <- map["description"]
//        icon <- map["icon"]
//    }
//}

final class Main: Mappable {

    // MARK: - Properties
    var temp: Double?
    var tempmax: Double?
    var tempMin: Double?
    var feelLike: Double?

    init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        temp <- map["temp"]
        tempmax <- map["temp_max"]
        tempMin <- map["temp_min"]
        feelLike <- map["feels_like"]
    }
}
