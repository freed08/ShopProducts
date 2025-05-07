//
//  NetworkService.swift
//  CountriesApp
//
//  Created by Frederick Lamoste on 5/6/25.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        _ url: String,
        method: HTTPMethod,
        parameters: Parameters?,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

class NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(
        _ url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(url, method: method, parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let successValue):
                    completion(.success(successValue))
                case .failure(let errorValue):
                    completion(.failure(errorValue))
                }
            }
    }
}
