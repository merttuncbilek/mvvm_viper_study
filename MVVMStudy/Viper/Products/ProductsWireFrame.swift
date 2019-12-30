//
//  ProductsWireFrame.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 17.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit

class ProductsWireFrame: BaseWireFrame {
    
    static func createProductsView() -> UIViewController? {
        let storyboard = super.getStoryBoard(with: "Main")
        if let productsViewController = storyboard.instantiateViewController(identifier: "ProductsViewController") as? ProductsViewController {
            var presenter: ProductsPresenterToInteractorProtocol & ProductsPresenterToViewProtocol = ProductsPresenter()
            let wireFrame: ProductsWireFrameToPresenterProtocol = ProductsWireFrame()
            var interactor: ProductsInteractorToPresenterProcotol = ProductsInteractor()
            
            presenter.view = productsViewController
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            productsViewController.presenter = presenter
            interactor.presenter = presenter
            
            return productsViewController
        }
        
        return nil
    }
    
   
}

extension ProductsWireFrame: ProductsWireFrameToPresenterProtocol {
    
    func openProductDetailView(from view: ProductsViewToPresenterProtocol, productId: String) {
        let productDetailController = ProductDetailWireFrame.createProductDetailView(productId: productId)
        if let controller = view as? UIViewController {
            controller.navigationController?.pushViewController(productDetailController, animated: true)
        }
    }
}
