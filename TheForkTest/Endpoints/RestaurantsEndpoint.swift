//
//  RestaurantsEndpoint.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//


import Foundation

enum RestaurantsEndpoint: RequestProtocol {
    
    case all
    
    var baseUrl: String {
        return "https://alanflament.github.io"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/TFTest/test.json"
    }
    
    var headers: RequestHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: RequestParameters? {
        return nil
    }
}
