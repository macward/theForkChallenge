//
//  Restaurant.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//

import Foundation

struct Restaurant: Codable {
    let uuid: String
    let name: String
    let address: String
    let rating: Double
    let imageUrl: String
    var isFavorite: Bool = false
}

extension Restaurant {
    init(responseObject: RestaurantResponseObject) {
        self.uuid = responseObject.uuid
        self.name = responseObject.name
        self.address = responseObject.address.street
        self.rating = responseObject.aggregateRatings.thefork.ratingValue
        self.imageUrl = responseObject.mainPhoto?.source ?? ""
    }
}


//extension Restaurant: Comparable {
//    static func < (lhs: Restaurant, rhs: Restaurant) -> Bool {
//        return lhs.name <
//    }
//    
//    
//}
