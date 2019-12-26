//
//  MProductsViewModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 20.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class MProductsViewModel: BaseViewModel, MProductsViewModelProtocol {
   
    var productsModel: MProductsModelProtocol = MProductsModel()
    
    var products = Observable<[Product]>()
    
    required init() {
        super.init()
        
        productsModel.productsResponse.observe = { productResponse in
            if let products = productResponse.products {
                self.products.value = products
            }
        }
    }
    
    override func observeError() {
        productsModel.observableError.observe = { error in
            self.error.value = error
        }
    }
    
    func fetchPosts() {
        productsModel.fetchProductsData()
    }
    
    func onProductItemSelected(at index: Int) {
        self.navigationEvent.value = NavigationEvent.init(target: .ProductDetail, payload: products.value[index].product_id as AnyObject?)
    }
}

