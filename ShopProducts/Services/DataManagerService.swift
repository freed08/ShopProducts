//
//  DataManagerService.swift
//  ShopProducts
//
//  Created by Frederick Lamoste on 5/7/25.
//
import Foundation

class DataManager {
    
    static let shared = DataManager()
    private let productsKey = "savedProducts"
    
    // Save products to UserDefaults
    func saveProducts(_ products: [ProductModel]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(products) {
            UserDefaults.standard.set(encoded, forKey: productsKey)
        }
    }
    
    // Load products from UserDefaults
    func loadProducts() -> [ProductModel]? {
        if let savedData = UserDefaults.standard.data(forKey: productsKey) {
            let decoder = JSONDecoder()
            if let loadedProducts = try? decoder.decode([ProductModel].self, from: savedData) {
                return loadedProducts
            }
        }
        return nil
    }
}
