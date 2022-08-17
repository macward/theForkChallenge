//
//  RestaurantsRepository.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//

import Foundation

protocol RestaurantRepository {
    func fetch() async throws -> [Restaurant]?
}
