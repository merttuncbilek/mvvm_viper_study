//
//  ProductsPresenter.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 17.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class ProductsPresenter: BasePresenter {
    var view: ProductsViewToPresenterProtocol?
    var wireFrame: ProductsWireFrameToPresenterProtocol?
    var interactor: ProductsInteractorToPresenterProcotol?
    
    internal var products = [Product]()
    
    override func onErrorReceived(message: String) {
        view?.dismissProgress()
        view?.showMessage(message)
    }
}

extension ProductsPresenter: ProductsPresenterToViewProtocol {
    
    func fetchProducts() {
        self.view?.showProgress()
        interactor?.fetchProductsData()
    }
    
    func numberOfProducts() -> Int {
        return products.count
    }
    
    func getProductItem(at index: Int) -> Product {
        return products[index]
    }
    
    func onProductItemSelected(at index: Int) {
        let productItem = self.products[index]
        if let sourceView = view {
            wireFrame?.openProductDetailView(from: sourceView, productId: productItem.product_id ?? "")
        }
    }
}

extension ProductsPresenter: ProductsPresenterToInteractorProtocol {
    
    func onProductsDataReceived(productResponse: ProductsResponse) {
        self.products = productResponse.products ?? [Product]()
        view?.dismissProgress()
        view?.productsFetched(productResponse: productResponse)
    }
    
    
}
