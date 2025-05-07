//
//  CountryAPIService.swift
//  CountriesApp
//
//  Created by Frederick Lamoste on 5/6/25.
//

import Foundation
import Alamofire

protocol ProductAPIServiceProtocol {
    func fetchProducts(urlString: String, completion: @escaping (Result<[ProductModel], Error>) -> Void)
}

class ProductAPIService: ProductAPIServiceProtocol {
   
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchProducts(urlString: String, completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        networkService.request(urlString, method: .get, parameters: nil, completion: completion)
    }
}
