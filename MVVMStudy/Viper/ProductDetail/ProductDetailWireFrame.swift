//
//  PostDetailWireFrame.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 20.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailWireFrame: BaseWireFrame, ProductDetailWireFrameToPresenterProtocol {
    
    static func createProductDetailView(productId: String) -> UIViewController {
        let storyboard = super.getStoryBoard(with: "Main")
        if let productDetailViewController = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            
            var presenter: ProductDetailPresenterToInteractorProtocol & ProductDetailPresenterToViewProtocol = ProductDetailPresenter()
            presenter.productId = productId
            
            var interactor: ProductDetailInteractorToPresenterProtocol = ProductDetailInteractor()
            let wireFrame: ProductDetailWireFrameToPresenterProtocol = ProductDetailWireFrame()
            
            productDetailViewController.presenter = presenter
            presenter.interactor = interactor
            interactor.presenter = presenter
            presenter.view = productDetailViewController
            presenter.wireFrame = wireFrame
            
            return productDetailViewController
            
        }
        
        return UIViewController()
    }
    
}
