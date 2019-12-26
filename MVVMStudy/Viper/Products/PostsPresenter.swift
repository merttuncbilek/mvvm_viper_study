//
//  PostsPresenter.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 17.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class PostsPresenter: BasePresenter {
    var view: PostsViewToPresenterProtocol?
    var wireFrame: PostsWireFrameToPresenterProtocol?
    var interactor: PostsInteractorToPresenterProcotol?
    
    internal var products = [Product]()
    
    override func onErrorReceived(message: String) {
        view?.dismissProgress()
        view?.showMessage(message)
    }
}

extension PostsPresenter: PostsPresenterToViewProtocol {
    
    func fetchPosts() {
        self.view?.showProgress()
        interactor?.fetchPostsData()
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

extension PostsPresenter: PostsPresenterToInteractorProtocol {
    
    func onPostsDataReceived(productResponse: ProductsResponse) {
        self.products = productResponse.products ?? [Product]()
        view?.dismissProgress()
        view?.postsFetched(productResponse: productResponse)
    }
    
    
}
