//
//  MProductsProtocols.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 20.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import Bond

protocol MProductsViewModelProtocol: BaseViewModelProtocol {
    var products: MutableObservableArray<Product> {get set}
    
    func fetchProducts()
    func onProductItemSelected(at index: Int)
}

protocol MProductsModelProtocol: BaseModelProtocol {
    var productsResponse: Observable<ProductsResponse?> {get set}
    
    func fetchProductsData()
}
