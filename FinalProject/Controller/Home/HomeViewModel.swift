//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/9/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation
import UIKit

typealias Completion2 = (Bool, String) -> Void

final class HomeViewModel {

    enum TypeCell: Int {
        case cell0 = 0
        case cell1
        case cell2
        case cell3
        case cell4
    }

    var weather: Weather?
    var main: Main?

    func viewModelForItem(indexPath: IndexPath) -> HomeTableViewCellViewModel {
        guard let weather = weather else { return HomeTableViewCellViewModel() }
        return HomeTableViewCellViewModel(mainWeather: MainWeather(weather: [weather], main: main))
    }

    func heightcell(at indexPath: IndexPath) -> CGFloat {
        guard let type = TypeCell(rawValue: indexPath.row) else { return 0 }
        switch type {
        case .cell0:
            return 200
        case .cell1:
            return 100
        case .cell2:
            return 100
        case .cell3:
            return 100
        case .cell4:
            return 100
        }
    }

    func getDataWeather(completion: @escaping APICompletion) {
        WeatherService.getDataWeather { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.weather = data.weather?.first
                this.main = data.main
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func convertToJSON(from data: Data) -> [String: Any] {
        var json: [String: Any] = [:]
        do {
          if let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
            json = jsonObj
          }
        } catch {
          print("JSON casting error")
        }
        return json
      }
}
