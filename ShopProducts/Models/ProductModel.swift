//
//  CountryModel.swift
//  CountriesApp
//
//  Created by Frederick Lamoste on 5/6/25.
//

import Foundation

struct ProductModel: Identifiable, Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}
