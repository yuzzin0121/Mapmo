//
//  NetworkError.swift
//  Mapmo
//
//  Created by 조유진 on 3/14/24.
//

import Foundation

enum NetworkError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}
