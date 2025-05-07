//
//  CountryListViewModel.swift
//  CountriesApp
//
//  Created by Frederick Lamoste on 5/6/25.
//

import SwiftUI

class ProductListViewModel: ObservableObject {
    
    @Published var products: [ProductModel] = []
    @Published var errorMessage: String?
    
    private let apiService = ProductAPIService()
    
    func loadProducts(urlStr: String, fromRefresh: Bool = false) {
        if fromRefresh || DataManager.shared.loadProducts() == nil {
            apiService.fetchProducts(urlString: urlStr) { [weak self] result in
                DispatchQueue.main.async {
                    self?.handleFetchResult(result)
                }
            }
        } else {
            if let savedProducts = DataManager.shared.loadProducts() {
                self.products = savedProducts
            }
        }
    }
    
    private func handleFetchResult(_ result: Result<[ProductModel], Error>) {
        switch result {
        case .success(let countries):
            print("✅ Successfully fetched products: \(countries)")
            self.products = countries
            DataManager.shared.saveProducts(products)
        case .failure(let error):
            print("❌ Error fetching products: \(error.localizedDescription)")
            self.handleError(error)
        }
    }

    private func handleError(_ error: Error) {
        if let urlError = error as? URLError {
            self.errorMessage = "Network error occurred: \(urlError.localizedDescription)"
        } else {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func filterProducts(by searchText: String) -> [ProductModel] {
        let filteredProducts = self.products.filter {
            searchText.isEmpty || $0.title.lowercased().contains(searchText.lowercased())
        }
        return filteredProducts
    }
}
