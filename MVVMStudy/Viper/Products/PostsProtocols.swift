//
//  PostsProtocols.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 17.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol PostsViewToPresenterProtocol: BaseViewProtocol {
    var presenter: PostsPresenterToViewProtocol? {get set}
    
    func postsFetched(productResponse: ProductsResponse)
}

protocol PostsPresenterToViewProtocol {
    var view: PostsViewToPresenterProtocol? {get set}
    var wireFrame: PostsWireFrameToPresenterProtocol?  {get set}
    
    var products: [Product] {get set}
    
    func fetchPosts()
    func numberOfProducts() -> Int
    func getProductItem(at index: Int) -> Product
    func onProductItemSelected(at index: Int)
}

protocol PostsWireFrameToPresenterProtocol {
    static func createPostsView() -> UIViewController?
    func openProductDetailView(from view: PostsViewToPresenterProtocol, productId: String )
}

protocol PostsPresenterToInteractorProtocol: BasePresenterProtocol {
    var interactor: PostsInteractorToPresenterProcotol? {get set}
    
    func onPostsDataReceived(productResponse: ProductsResponse)
}

protocol PostsInteractorToPresenterProcotol {
    var presenter: PostsPresenterToInteractorProtocol? {get set}
    
    func fetchPostsData()
}
