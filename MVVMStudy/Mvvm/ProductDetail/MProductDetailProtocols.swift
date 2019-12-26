//
//  MProductDetailProtocols.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 25.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

protocol ProductDetailViewModelProtocol: BaseViewModelProtocol {
    var productDetailModel: ProductDetailModelProtocol {get set}
    var productDetail: Observable<ProductDetail> {get set}
    
    func getProductDetail(id: String)
}

protocol ProductDetailModelProtocol: BaseModelProtocol {
    var productDetail: Observable<ProductDetail> {get set}
    
    func getProductDetail(id: String)
}
