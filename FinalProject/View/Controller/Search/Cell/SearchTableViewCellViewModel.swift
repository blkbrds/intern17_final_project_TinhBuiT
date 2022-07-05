//
//  SearchTableViewCellViewModel.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/30/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

final class SearchTableViewCellViewModel {

    // MARK: - Properties
    var search: Search?
    let realm = try? Realm()
    var isFavorite: Bool = false

    // MARK: - Initialize
    init() {}

    init(search: Search?, isFavorite: Bool) {
        self.search = search
        self.isFavorite = isFavorite
    }

    func getName() -> String {
        let name = search?.name ?? ""
        let state = search?.state ?? ""
        let country = search?.country ?? ""
        let address = name + ", " + state + ", " + country
        return address
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
