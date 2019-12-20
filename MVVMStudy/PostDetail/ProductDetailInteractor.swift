//
//  PostDetailInteractor.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 20.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class ProductDetailInteractor: ProductDetailInteractorToPresenterProtocol {
    
    var presenter: ProductDetailPresenterToInteractorProtocol?
    
    func fetchProductDetail(with id: String) {
        let requestMethod = String.init(format: Constants.METHOD_DETAIL, id)
        RemoteDataSource.shared.getFromApi(ProductDetail.self, method: requestMethod, onResponse: { success, data, error in
            if success {
                if let data = data {
                    self.presenter?.onProductDetailFetched(productDetail: data)
                }
            } else {
                self.presenter?.onErrorReceived(message: error?.localizedDescription ?? "Error")
            }
        })
    }
}
