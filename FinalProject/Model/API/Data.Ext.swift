//
//  Data.Ext.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/10/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

extension Data {
    func toJSON() -> JSON {
        var json: [String: Any] = [:]
        do {
            if let jsonObj = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? JSON {
                json = jsonObj
            }
        } catch {
            print("JSON casting error")
        }
        return json
    }
}
