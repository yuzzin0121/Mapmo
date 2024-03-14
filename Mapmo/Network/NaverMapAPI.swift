//
//  NaverMapAPI.swift
//  Mapmo
//
//  Created by 조유진 on 3/14/24.
//

import Foundation
import Alamofire

enum NaverMapAPI {
    case place(query: String, display: Int, sort: String)
    
    var baseURL: String {
        return "https://openapi.naver.com/v1/"
    }
    
    var endpoint: URL {
        switch self {
        case .place(let query, let display, let sort):
            return URL(string: baseURL + "search/local.json?query=\(query)&display=\(display)&sort=\(sort)")!
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .place:
            return ["X-Naver-Client-Id": APIKey.xNaverClientId, "X-Naver-Client-Secret": APIKey.xNaverClientSecret]
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        default:
            return [:]
        }
    }
}
