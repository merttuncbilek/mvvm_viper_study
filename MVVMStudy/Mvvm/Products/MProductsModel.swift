//
//  MProductsModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 20.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import Bond

class MProductsModel: BaseModel, MProductsModelProtocol {
    var productsResponse = Observable<ProductsResponse?>(nil)
    
    func fetchProductsData() {
        RemoteDataSource.shared.getFromApi(ProductsResponse.self, method: Constants.METHOD_LIST, onResponse: { result in
            do {
                let productResponse = try result.get()
                self.productsResponse.send(productResponse)
            } catch let error {
                self.observableError.send(error.localizedDescription)
            }
        })
    }
    
}
