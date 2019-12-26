//
//  MProductsViewModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 20.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class MProductsViewModel: BaseViewModel<MProductsModel>, MProductsViewModelProtocol {
   
    var products = Observable<[Product]>()
    
    override func setUpObserves() {
        model.productsResponse.observe = { productResponse in
            if let products = productResponse.products {
                self.products.value = products
            }
        }
    }
    
    func fetchPosts() {
        model.fetchProductsData()
    }
    
    func onProductItemSelected(at index: Int) {
        self.navigationEvent.value = NavigationEvent.init(target: .ProductDetail, payload: products.value[index].product_id as AnyObject?)
    }
}
