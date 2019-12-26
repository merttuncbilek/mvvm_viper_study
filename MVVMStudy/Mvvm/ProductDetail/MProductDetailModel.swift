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
        RemoteDataSource.shared.getFromApi(ProductDetail.self, method: requestMethod, onResponse: { success, data, error in
            if success {
                if let data = data {
                    self.productDetail.value = data
                }
            } else {
                self.observableError.value = error?.localizedDescription ?? "Error"
            }
        })
    }
    
}
