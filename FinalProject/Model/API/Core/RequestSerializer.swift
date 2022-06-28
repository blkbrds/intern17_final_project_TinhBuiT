//
//  App.swift
//  FinalProject
//
//  Created by Bien Le Q. on 8/26/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension ApiManager {

    @discardableResult
    func request(method: HTTPMethod,
                 urlString: URLStringConvertible,
                 parameters: [String: Any]? = nil,
                 encoding: ParameterEncoding = URLEncoding.default,
                 headers: [String: String]? = nil,
                 completion: Completion<Any>?) -> Request? {
        guard Network.shared.isReachable else {
            completion?(.failure(Api.Error.network))
            return nil
        }

        var header = api.defaultHTTPHeaders
        header.updateValues(headers)

        let request = Alamofire.request(urlString.urlString,
                                        method: method,
                                        parameters: parameters,
                                        encoding: encoding,
                                        headers: header
            ).responseJSON { (response) in
                // Fix bug AW-4571: Call request one more time when see error 53 or -1_005
                if let error = response.error,
                    error.code == Api.Error.connectionAbort.code || error.code == Api.Error.connectionWasLost.code {
                    Alamofire.request(urlString.urlString,
                                      method: method,
                                      parameters: parameters,
                                      encoding: encoding,
                                      headers: header
                        ).responseJSON { response in
                            completion?(response.result)
                    }
                } else {
                    completion?(response.result)
                }
        }
        return request
    }
}


//extension Mapper {
//
//    func mapObject<T: NSObject>(_ result: Result<Any>, completion: @escaping (_ item: T?, _ error: Error?) -> Void) where T: Mappable {
//        switch result {
//        case .success(let json):
//            guard let json = json as? JSObject else {
//                DispatchQueue.main.async {
//                    completion(nil, Api.Error.json)
//                }
//                return
//            }
//            if let obj: T = Mapper<T>().map(JSON: json) {
//                DispatchQueue.main.async {
//                    completion(obj, nil)
//                }
//            } else {
//                DispatchQueue.main.async {
//                    completion(nil, nil)
//                }
//            }
//        case .failure(let error):
//            DispatchQueue.main.async {
//                completion(nil, error)
//            }
//        }
//    }
//
//    func mapArray<T>(_ result: Result<Any>, completion: @escaping (_ items: [T]?, _ nextPageToken: String?, _ error: Error?) -> Void) where T: Mappable {
//        switch result {
//        case .success(let json):
//            guard let json = json as? JSObject else {
//                DispatchQueue.main.async {
//                    completion(nil, nil, Api.Error.json)
//                }
//                return
//            }
//            guard let nextPageToken = json[“nextPageToken”] as? String else { return }
//            guard let data = json[“items”] as? JSArray else {
//                return
//            }
//            let items: [T] = Mapper<T>().mapArray(JSONArray: data)
//            DispatchQueue.main.async {
//                completion(items, nextPageToken, nil)
//            }
//        case .failure(let error):
//            DispatchQueue.main.async {
//                completion(nil, nil, error)
//            }
//        }
//    }
//}
