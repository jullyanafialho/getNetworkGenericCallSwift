//
//  Network.swift
//  PaginationTableView
//
//  Created by Jullyana Fialho on 23/03/19.
//  Copyright © 2019 Jullyana Fialho. All rights reserved.
//

import Foundation
import Alamofire

class Network {
    let getExpectedStatusCode = 200
    func get<T: Decodable>(from: String, decodable: T.Type, completion:@escaping (_ details: T?) -> Void) {
        Alamofire.request(from, method: .get).responseJSON { response in
            guard let status = response.response?.statusCode, status != self.getExpectedStatusCode else {
                completion(nil)
                return
            }
            guard let result = response.data else {
                completion(nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(T.self, from: result)
                completion(data)
            } catch let error as NSError {
                print("error : \(error)")
            }
            completion(nil)
        }
    }
}
