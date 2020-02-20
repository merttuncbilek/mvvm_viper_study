//
//  MProductsViewModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 20.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import Bond

enum ProductsViewState: ViewState {
    case productsFetched(Bool)
}

class MProductsViewModel: BaseViewModel, MProductsViewModelProtocol {
   
    var products = MutableObservableArray<Product>()
    var model: MProductsModelProtocol
    
    required convenience init() {
        self.init(model: MProductsModel())
    }
    
    init(model: MProductsModelProtocol) {
        self.model = model
        super.init()
        super.observeError(on: self.model)
    }
    
    override func setUpObserves() {
        model.productsResponse.observeNext {[weak self] productResponse in
            if let products = productResponse?.products {
                self?.products.replace(with: products)
                self?.state.send(ProductsViewState.productsFetched(true))
            }
        }.dispose(in: bag)
    }
    
    func fetchProducts() {
        model.fetchProductsData()
    }
    
    func onProductItemSelected(at index: Int) {
        self.navigationEvent.send(NavigationEvent.init(target: .ProductDetail, payload: products[index].product_id as AnyObject?))
    }
}
