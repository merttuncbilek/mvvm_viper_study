//
//  MProductDetailViewModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 25.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class MProductDetailViewModel: BaseViewModel, ProductDetailViewModelProtocol {
    
    var productDetail = Observable<ProductDetail>()
    var model: ProductDetailModelProtocol
    
    required convenience init() {
        self.init(model: MProductDetailModel())
    }
    
    init(model: ProductDetailModelProtocol) {
        self.model = model
        super.init()
        self.observeError(on: model)
        
    }
    
    override func setUpObserves() {
        model.productDetail <-> {[weak self] productDetail in
            self?.productDetail.value = productDetail
        }
    }
    
    func getProductDetail(id: String) {
        model.getProductDetail(id: id)
    }
}
