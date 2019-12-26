//
//  ProductDetailProtocols.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 20.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit

//MARK: View -> Presenter
protocol ProductDetailViewToPresenterProtocol: BaseViewProtocol {
    var presenter: ProductDetailPresenterToViewProtocol? {get set}
    
    func showProductDetail(_ productDetail: ProductDetail)
}

//MARK: Presenter -> View
protocol ProductDetailPresenterToViewProtocol {
    var view: ProductDetailViewToPresenterProtocol? {get set}
    var wireFrame: ProductDetailWireFrameToPresenterProtocol? {get set}
    
    var productId: String? {get set}
    
    func getProductDetail()
}

//MARK: ViewFrame
protocol ProductDetailWireFrameToPresenterProtocol {
    static func createProductDetailView(productId: String) -> UIViewController
}

//MARK: Presenter -> Interactor
protocol ProductDetailPresenterToInteractorProtocol: BasePresenterProtocol {
    var interactor: ProductDetailInteractorToPresenterProtocol? {get set}
    
    func onProductDetailFetched(productDetail: ProductDetail)
}

//MARK: Interactor -> Presenter
protocol ProductDetailInteractorToPresenterProtocol {
    var presenter: ProductDetailPresenterToInteractorProtocol? {get set}
    
    func fetchProductDetail(with id: String)
}
