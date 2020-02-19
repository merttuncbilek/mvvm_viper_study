//
//  MProductsViewModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 20.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class MProductsViewModel: BaseViewModel, MProductsViewModelProtocol {
   
    var products = Observable<[Product]>()
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
        model.productsResponse <-> {[weak self] productResponse in
            if let products = productResponse.products {
                self?.products.value = products
            }
        }
    }
    
    func fetchProducts() {
        model.fetchProductsData()
    }
    
    func onProductItemSelected(at index: Int) {
        self.navigationEvent.value = NavigationEvent.init(target: .ProductDetail, payload: products.value[index].product_id as AnyObject?)
    }
}
