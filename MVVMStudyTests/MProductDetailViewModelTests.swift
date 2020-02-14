//
//  MProductsViewModelTests.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 10.01.2020.
//  Copyright © 2020 Evrensel Software Solutions. All rights reserved.
//

import XCTest
@testable import MVVMStudy

class MProductDetailViewModelTests: XCTestCase {
    
    var productDetailViewModel: MProductDetailViewModel!
    
    override func setUp() {
        super.setUp()
        productDetailViewModel = MProductDetailViewModel()
    }
    
    func testFetchProductDetail() {
        
        self.productDetailViewModel.productDetail <-> { productDetail in
            XCTAssert(productDetail != nil, "Product Detail Fetched")
        }
        
        async(function: {
            self.productDetailViewModel.getProductDetail(id: "1")
        })
        
    }
}
