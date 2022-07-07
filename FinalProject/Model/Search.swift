//
//  Search.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/28/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

final class Search: Object, Mappable {

    // MARK: - Properties
    @objc dynamic var id: String = ""
    @objc dynamic var name: String?
    @objc dynamic var lat: Double = 0
    @objc dynamic var lon: Double = 0
    @objc dynamic var country: String?
    @objc dynamic var state: String?

    override class func primaryKey() -> String? {
        return "id"
    }

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        name <- map["name"]
        lat <- map["lat"]
        lon <- map["lon"]
        country <- map["country"]
        state <- map["state"]
        id = String(lat)
    }
}
