//
//  PostsWireFrame.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 17.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit

class PostsWireFrame: BaseWireFrame {
    
    static func createPostsView() -> UIViewController? {
        let storyboard = super.getStoryBoard(with: "Main")
        if let postsViewController = storyboard.instantiateViewController(identifier: "PostsViewController") as? PostsViewController {
            var presenter: PostsPresenterToInteractorProtocol & PostsPresenterToViewProtocol = PostsPresenter()
            let wireFrame: PostsWireFrameToPresenterProtocol = PostsWireFrame()
            var interactor: PostsInteractorToPresenterProcotol = PostsInteractor()
            
            presenter.view = postsViewController
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            postsViewController.presenter = presenter
            interactor.presenter = presenter
            
            return postsViewController
        }
        
        return nil
    }
    
   
}

extension PostsWireFrame: PostsWireFrameToPresenterProtocol {
    
    func openProductDetailView(from view: PostsViewToPresenterProtocol, productId: String) {
        let productDetailController = ProductDetailWireFrame.createProductDetailView(productId: productId)
        if let controller = view as? UIViewController {
            controller.navigationController?.pushViewController(productDetailController, animated: true)
        }
    }
}
