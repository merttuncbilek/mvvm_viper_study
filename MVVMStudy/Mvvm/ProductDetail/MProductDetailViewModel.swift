//
//  MProductDetailViewModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 25.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class MProductDetailViewModel: BaseViewModel, ProductDetailViewModelProtocol {
    
    var productDetailModel: ProductDetailModelProtocol = MProductDetailModel()
    var productDetail = Observable<ProductDetail>()
    
    required init() {
        super.init()
        productDetailModel.productDetail.observe = { productDetail in
            self.productDetail.value = productDetail
        }
    }
    
    override func observeError() {
        productDetailModel.observableError.observe = { error in
            super.error.value = error
        }
    }
    
    func getProductDetail(id: String) {
        productDetailModel.getProductDetail(id: id)
    }
}
