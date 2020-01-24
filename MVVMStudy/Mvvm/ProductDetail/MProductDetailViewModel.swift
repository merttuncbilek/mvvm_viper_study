//
//  MProductDetailViewModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 25.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class MProductDetailViewModel: BaseViewModel<MProductDetailModel>, ProductDetailViewModelProtocol {
    
    var productDetail = Observable<ProductDetail>()
    
    override func setUpObserves() {
        model.productDetail <-> {[weak self] productDetail in
            self?.productDetail.value = productDetail
        }
    }
    
    func getProductDetail(id: String) {
        model.getProductDetail(id: id)
    }
}
