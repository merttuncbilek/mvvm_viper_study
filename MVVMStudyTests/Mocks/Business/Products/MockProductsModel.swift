//
//  MockProductModel.swift
//  MVVMStudyTests
//
//  Created by Mert Tuncbilek on 18.02.2020.
//  Copyright © 2020 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class MockProductsModel:BaseModel, MProductsModelProtocol {
    var productsResponse = Observable<ProductsResponse>()
    
    func fetchProductsData() {
        self.productsResponse.value = MockProductResponse.createProductResponse()
    }
    
}
