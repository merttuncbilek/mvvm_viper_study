//
//  MProductDetailViewModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 25.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import Bond

protocol ProductDetailViewModelProtocol: BaseViewModelProtocol {
    var productDetail: Observable<ProductDetail?> {get set}
    
    func getProductDetail(id: String)
    func onProductImageSelected()
}

class MProductDetailViewModel: BaseViewModel, ProductDetailViewModelProtocol {
    
    var productDetail = Observable<ProductDetail?>(nil)
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
        model.productDetail.observeNext {[weak self] productDetail in
            self?.productDetail.send(productDetail)
        }.dispose(in: bag)
    }
    
    func getProductDetail(id: String) {
        model.getProductDetail(id: id)
    }
    
    func onProductImageSelected() {
        self.navigationEvent.send(NavigationEvent(target: .UIElementsView))
    }
}
