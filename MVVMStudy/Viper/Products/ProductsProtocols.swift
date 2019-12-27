//
//  ProductsProtocols.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 17.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol ProductsViewToPresenterProtocol: BaseViewProtocol {
    var presenter: ProductsPresenterToViewProtocol? {get set}
    
    func productsFetched(productResponse: ProductsResponse)
}

protocol ProductsPresenterToViewProtocol {
    var view: ProductsViewToPresenterProtocol? {get set}
    var wireFrame: ProductsWireFrameToPresenterProtocol?  {get set}
    
    var products: [Product] {get set}
    
    func fetchProducts()
    func numberOfProducts() -> Int
    func getProductItem(at index: Int) -> Product
    func onProductItemSelected(at index: Int)
}

protocol ProductsWireFrameToPresenterProtocol {
    static func createProductsView() -> UIViewController?
    func openProductDetailView(from view: ProductsViewToPresenterProtocol, productId: String )
}

protocol ProductsPresenterToInteractorProtocol: BasePresenterProtocol {
    var interactor: ProductsInteractorToPresenterProcotol? {get set}
    
    func onProductsDataReceived(productResponse: ProductsResponse)
}

protocol ProductsInteractorToPresenterProcotol {
    var presenter: ProductsPresenterToInteractorProtocol? {get set}
    
    func fetchProductsData()
}
