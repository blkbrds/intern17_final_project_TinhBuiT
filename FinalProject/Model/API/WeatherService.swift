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
    static func getDataMainApi(lat: Double, lon: Double, completion: @escaping Completion<MainApi>) {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall"
        var params: [String: Any] = [:]
        params["lat"] = lat
        params["lon"] = lon
        params["appid"] = "4d8532b3f8d712217bea8a168dd2af8f"
        api.request(method: .get, urlString: urlString, parameters: params) { result in
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

    static func getDataSearchApi(address: String, completion: @escaping Completion<[Search]>) {
        let urlString = "http://api.openweathermap.org/geo/1.0/direct"
        var params: [String: Any] = [:]
        params["q"] = address
        params["limit"] = 5
        params["appid"] = "4d8532b3f8d712217bea8a168dd2af8f"
        api.request(method: .get, urlString: urlString, parameters: params) { result in
            switch result {
            case .success(let data):
                if let data = data as? JSArray,
                   let search = Mapper<Search>().mapArray(JSONObject: data) {
                    completion(.success(search))
                } else {
                    completion(.failure(Api.Error.json))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func loadImageByCountry(_ country: String, completion: @escaping Completion<UIImage?>) {
        var image: UIImage?
        let imgUrl: String = "https://openweathermap.org/images/flags/\(country).png"
        guard let url = URL(string: imgUrl) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    guard let data = data else {
                        completion(.failure(Api.Error.emptyData))
                        return
                    }
                    image = UIImage(data: data)
                    completion(.success(image))
                }
            }
        }
        task.resume()
    }
}
