//
//  PostDetailPresenter.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 20.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class ProductDetailPresenter: BasePresenter {
    
    var interactor: ProductDetailInteractorToPresenterProtocol?
    var wireFrame: ProductDetailWireFrameToPresenterProtocol?
    var view: ProductDetailViewToPresenterProtocol?
    
    var productId: String?
    
    override func onErrorReceived(message: String) {
        view?.dismissProgress()
        view?.showMessage(message)
    }
    
}

extension ProductDetailPresenter: ProductDetailPresenterToViewProtocol {
    
    func getProductDetail() {
        view?.showProgress()
        interactor?.fetchProductDetail(with: productId ?? "")
    }
    
}

extension ProductDetailPresenter: ProductDetailPresenterToInteractorProtocol {
    
    func onProductDetailFetched(productDetail: ProductDetail) {
        view?.dismissProgress()
        view?.showProductDetail(productDetail)
    }
    
}

