//
//  ShopProductsTests.swift
//  ShopProductsTests
//
//  Created by Frederick Lamoste on 5/7/25.
//

import Foundation
import Testing
@testable import ShopProducts
import XCTest

// MARK: - Unit Test Class
class ProductListViewModelTests: XCTestCase {
    
    var viewModel: ProductListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ProductListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // Test: Successful loading of products
    func testLoadProducts_Success() {
        let expectation = self.expectation(description: "Products loaded")
        
        viewModel.loadProducts(urlStr: "http://fakestoreapi.com/products")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertTrue(viewModel.products.count > 0, "Products count should be greater than 0")

    }
    
    // Test: Handle data persistence (mock data loading)
    func testLoadProducts_WithSavedData() {
        viewModel.loadProducts(urlStr: "http://fakestoreapi.com/products")
        
        XCTAssertTrue(viewModel.products.count > 0, "Products count should be greater than 0")
    }
}
