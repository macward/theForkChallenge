//
//  RestaurantResponseObject.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//

import Foundation

struct RestaurantRequestResponseObject: Codable {
    let data: [RestaurantResponseObject]
}

struct RestaurantResponseObject: Codable {
    let uuid: String
    let name: String
    let address: AddressResponseObject
    let aggregateRatings: RatingResponseObject
    let mainPhoto: PhotoResponseObejct?
}


struct AddressResponseObject: Codable {
    let street: String
    let postalCode: String
    let locality: String
    let country: String
}

struct RatingResponseObject: Codable {
    let thefork: RatingItemResponseObject
    let tripadvisor: RatingItemResponseObject
}

struct RatingItemResponseObject: Codable {
    let ratingValue: Double
    let reviewCount: Int
}

struct PhotoResponseObejct: Codable {
    var source: String
}
