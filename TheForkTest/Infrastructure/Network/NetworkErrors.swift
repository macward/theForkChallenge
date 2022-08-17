//
//  NetworkErrors.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//

import Foundation

enum APIError: Error, Equatable {
    case noData
    case invalidResponse
    case badRequest(String?)
    case serverError(String?)
    case parseError(String?)
    case unknown
}
