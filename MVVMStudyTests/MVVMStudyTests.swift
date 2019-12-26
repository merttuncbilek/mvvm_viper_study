//
//  MVVMStudyTests.swift
//  MVVMStudyTests
//
//  Created by Mert TUNÇBİLEK on 12.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import XCTest
@testable import MVVMStudy

class MVVMStudyTests: XCTestCase {

    var productsViewModel: MProductsViewModel?
    var productDetailViewModel: MProductDetailViewModel?
    var products: [Product]?
    
    override func setUp() {
        super.setUp()
        self.productsViewModel = MProductsViewModel()
    }

    override func tearDown() {
        self.productsViewModel = nil
        super.tearDown()
    }
    
    func test1ProductsFetching() {
        self.simulateProductListFetching()
        
    }
    
    func test2ProductDetailFetching() {
        self.productDetailViewModel = MProductDetailViewModel()
        
        self.simulateProductListFetching()
        
        self.simulateProductDetailFetching(with: 0)
        
        super.addTeardownBlock {
            self.products = nil
            self.productDetailViewModel = nil
        }
    }

    private func simulateProductListFetching() {
        let productListExpectation = expectation(description: "ProductList Fetching")
        productsViewModel?.products.observe = { products in
            XCTAssert(products.count >= 1, "Products should be fetched")
            self.products = products
            
            productListExpectation.fulfill()
            
        }
        
        self.productsViewModel?.fetchPosts()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    private func simulateProductDetailFetching(with index: Int) {
        let productDetailExpectation = expectation(description: "ProductDetail Fetching")
        
        self.productDetailViewModel?.productDetail.observe = { productDetail in
            XCTAssert(productDetail != nil, "Product Detail must not be null")
            XCTAssert(productDetail.id == self.products![index].product_id, "Wrong product detail has been fetched")
            
            productDetailExpectation.fulfill()
        }
        
        XCTAssert(self.products != nil, "Product List must not be null")
        XCTAssert(self.products![index].product_id != nil, "Product Id must not be null")

        self.productDetailViewModel?.getProductDetail(id: self.products![index].product_id!)
        
        waitForExpectations(timeout: 15, handler: nil)
    }
}
