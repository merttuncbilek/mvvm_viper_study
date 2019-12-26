//
//  MProductsModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 20.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class MProductsModel: BaseModel, MProductsModelProtocol {
    var productsResponse = Observable<ProductsResponse>()
    
    func fetchProductsData() {
        RemoteDataSource.shared.getFromApi(ProductsResponse.self, method: Constants.METHOD_LIST, onResponse: { success, data, error in
            if success {
                if let data = data {
                    self.productsResponse.value = data
                }
            } else {
                self.observableError.value = error?.localizedDescription ?? "Error"
            }
        })
    }
    
}
