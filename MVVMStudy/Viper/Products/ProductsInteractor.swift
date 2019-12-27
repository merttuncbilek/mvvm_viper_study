//
//  ProductsInteractor.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 18.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class ProductsInteractor {
    var presenter: ProductsPresenterToInteractorProtocol?
    
}

extension ProductsInteractor: ProductsInteractorToPresenterProcotol {
     
    func fetchProductsData() {
        RemoteDataSource.shared.getFromApi(ProductsResponse.self, method: Constants.METHOD_LIST, onResponse: { success, data, error in
            if success {
                if let data = data {
                    self.presenter?.onProductsDataReceived(productResponse: data)
                }
            } else {
                self.presenter?.onErrorReceived(message: error?.localizedDescription ?? "Error")
            }
        })
    }
    
}
