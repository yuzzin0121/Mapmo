//
//  NaverMapAPIManager.swift
//  Mapmo
//
//  Created by 조유진 on 3/14/24.
//

import Foundation
import Alamofire

final class NaverMapAPIManager {
    static let shared = NaverMapAPIManager()
    private init() { }
    
    func fetchData<T: Decodable>(type: T.Type, api: NaverMapAPI, completionHandler: @escaping (T?, NetworkError?) -> Void) {
        print(api.endpoint)
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .validate()
        .responseDecodable(of: type) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success, nil)
            case .failure(let failure):
                completionHandler(nil, .failedRequest)
                print(failure)
            }
        }
    }
    
}
