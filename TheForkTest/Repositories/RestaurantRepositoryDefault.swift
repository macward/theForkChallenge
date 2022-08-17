//
//  RestaurantRepositoryDefault.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//

import Foundation

class RestaurantRepositoryDefault: RestaurantRepository {
    
    private let session = NetworkSession()
    private lazy var dispatcher = RequestDispatcher(networkSession: session)
    
    func fetch() async throws -> [Restaurant]? {
        let request = RestaurantsEndpoint.all
        
        guard let result = try await dispatcher.execute(urlRequest: request, of: RestaurantRequestResponseObject.self) else {
            throw APIError.noData
        }

        return result.data.map { object in
            Restaurant(responseObject: object)
        }
    }
    
}
