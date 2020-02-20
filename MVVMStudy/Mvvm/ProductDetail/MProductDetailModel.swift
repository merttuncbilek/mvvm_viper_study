//
//  ProductDetailModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 25.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import Bond

class MProductDetailModel: BaseModel, ProductDetailModelProtocol {
    
    var productDetail = Observable<ProductDetail?>(nil)
    
    func getProductDetail(id: String) {
        let requestMethod = String.init(format: Constants.METHOD_DETAIL, id)
        RemoteDataSource.shared.getFromApi(ProductDetail.self, method: requestMethod, onResponse: { result in
            do {
                let productDetail = try result.get()
                self.productDetail.send(productDetail)
            } catch let error {
                self.observableError.send(error.localizedDescription)
            }
        })
    }
    
}
