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
        RemoteDataSource.shared.getFromApi(ProductDetail.self, method: requestMethod, onResponse: { result in
            do {
                self.presenter?.onProductDetailFetched(productDetail: try result.get())
            } catch let error {
                self.presenter?.onErrorReceived(message: error.localizedDescription)
            }
        })
    }
}
