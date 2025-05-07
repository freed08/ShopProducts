//
//  ShopProductsUITests.swift
//  ShopProductsUITests
//
//  Created by Frederick Lamoste on 5/7/25.
//

import XCTest

final class ShopProductsUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testProductListLoadsAndDisplays() {
        // Check if the product list appears
        let productList = app.scrollViews
        XCTAssertTrue(productList.firstMatch.exists, "Product list should be visible")
        
        // Wait for at least one product card to appear
        let firstProduct = app.staticTexts.element(boundBy: 0)
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: firstProduct, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(firstProduct.exists, "First product should appear in the list")
    }
    
    func testNavigateToProductDetails() {
        let firstProduct = app.staticTexts.element(boundBy: 0)
        XCTAssertTrue(firstProduct.exists, "First product should exist in the list")
        
        // Tap the product to navigate
        firstProduct.tap()
        
        // Check if details view shows product title
        let detailsTitle = app.staticTexts.element(boundBy: 0)
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: detailsTitle, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(detailsTitle.exists, "Details screen should appear with product title")
    }
}

