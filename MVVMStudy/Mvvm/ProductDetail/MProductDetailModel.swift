//
//  ProductDetailModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 25.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class MProductDetailModel: BaseModel, ProductDetailModelProtocol {
    
    var productDetail = Observable<ProductDetail>()
    
    func getProductDetail(id: String) {
        let requestMethod = String.init(format: Constants.METHOD_DETAIL, id)
        RemoteDataSource.shared.getFromApi(ProductDetail.self, method: requestMethod, onResponse: { result in
            do {
                self.productDetail.value = try result.get()
            } catch let error {
                self.observableError.value = error.localizedDescription
            }
        })
    }
    
}
