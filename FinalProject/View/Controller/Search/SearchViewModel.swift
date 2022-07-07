//
//  SearchViewModel.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/28/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation
import RealmSwift

final class SearchViewModel {

    // MARK: - Properties
    var searches: [Search] = []
    let realm = try? Realm()
    var isSearching: Bool = false

    // MARK: - Functions
    func numberOfRows() -> Int {
        return searches.count
    }

    func getDataSearch(keySearch: String, completion: @escaping APICompletion) {
        WeatherService.getDataSearchApi(address: keySearch) { [weak self ] result in
            guard let this = self else { return }
            switch result {
            case .success(let search):
                this.searches = []
                this.searches = search
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func viewModelForHome(at indexPath: IndexPath) -> HomeViewModel {
        return HomeViewModel(lat: searches[indexPath.row].lat, lon: searches[indexPath.row].lon, isFromSearch: true, name: searches[indexPath.row].name ?? "")
    }

    func viewModelForSearch(at indexPath: IndexPath) -> SearchTableViewCellViewModel {
        return SearchTableViewCellViewModel(search: searches[indexPath.row], isFavorite: isFavorite(at: indexPath))
    }

    func fetchData(completion: (Bool) -> Void) {
        do {
            let realm = try Realm()
            let results = realm.objects(Search.self)
            searches = Array(results)
            completion(true)

        } catch {
            completion(false)
        }
    }

    func isFavorite(at indexPath: IndexPath) -> Bool {
        let id = searches[indexPath.row].id
        return realm?.objects(Search.self).filter("id = %@", id).toArray(ofType: Search.self).first != nil
    }

    func saveSearchToRealm(at indexPath: IndexPath) {
        try? realm?.write {
            let search = searches[indexPath.row]
            realm?.create(Search.self, value: search, update: .all)
        }
    }

    func removeSearchFromRealm(at indexPath: IndexPath) {
        let id = searches[indexPath.row].id
        guard let object = realm?.objects(Search.self).filter("id = %@", id).toArray(ofType: Search.self).first else { return }
        try? realm?.write {
            realm?.delete(object)
            checkToUpdateData(at: indexPath	)
        }
    }

    func checkToUpdateData(at indexPath: IndexPath) {
        if !isSearching {
            searches.remove(at: indexPath.row)
        }
    }
}
