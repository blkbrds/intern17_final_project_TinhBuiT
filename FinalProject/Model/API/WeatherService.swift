//
//  WeatherService.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/13/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

final class WeatherService {

    // MARK: - Function
    static func getDataWeather(completion: @escaping Completion<MainWeather>) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=16.054407&lon=108.202164&appid=4d8532b3f8d712217bea8a168dd2af8f"
        api.request(method: .get, urlString: urlString) { result in
            switch result {
            case .success(let data):
                if let data = data as? JSObject,
                   let items = data["weather"] as? JSArray,
                   let main = data["main"] as? JSObject {
                    var weathers: [Weather] = []
                    let main = Main(json: main)
                    for item in items {
                        weathers.append(Weather(json: item))
                    }
                    completion(.success(MainWeather(weather: weathers, main: main)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
