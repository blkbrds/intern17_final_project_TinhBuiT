//
//  WeatherService.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/13/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation
import ObjectMapper

final class WeatherService {

    // MARK: - Function
    static func getDataWeather(completion: @escaping Completion<MainWeather>) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=16.054407&lon=108.202164&appid=4d8532b3f8d712217bea8a168dd2af8f"
        api.request(method: .get, urlString: urlString) { result in
            switch result {
            case .success(let data):
                if let jsonObject = data as? JSObject, let mainWeather = Mapper<MainWeather>().map(JSON: jsonObject) {
                    completion(.success(mainWeather))
                } else {
                    completion(.failure(Api.Error.json))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func getDataMainApi(completion: @escaping Completion<MainApi>) {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=16.054407&lon=108.202164&appid=4d8532b3f8d712217bea8a168dd2af8f"
        api.request(method: .get, urlString: urlString) { result in
            switch result {
            case .success(let data):
                if let data = data as? JSObject,
                   let mainApi = Mapper<MainApi>().map(JSON: data) {
                    completion(.success(mainApi))
                } else {
                    completion(.failure(Api.Error.json))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
