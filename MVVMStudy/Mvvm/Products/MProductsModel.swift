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
        RemoteDataSource.shared.getFromApi(ProductsResponse.self, method: Constants.METHOD_LIST, onResponse: { result in
            do {
                self.productsResponse.value = try result.get()
            } catch let error {
                self.observableError.value = error.localizedDescription
            }
        })
    }
    
}
