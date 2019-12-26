//
//  PostDetailViewController.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 20.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ProductDetailViewController: BaseViewController {
    
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    var presenter: ProductDetailPresenterToViewProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getProductDetail() 
    }
}

extension ProductDetailViewController: ProductDetailViewToPresenterProtocol {
    
    func showProductDetail(_ productDetail: ProductDetail) {
        self.title = productDetail.name ?? ""
        
        self.labelProductName.text = productDetail.name ?? ""
        self.labelPrice.text = "\(productDetail.price ?? 0)"
        self.labelDescription.text = productDetail.description ?? ""
        if let url = URL(string: productDetail.image ?? "") {
            self.imageProduct.kf.setImage(with: ImageResource(downloadURL: url, cacheKey: productDetail.name))
        }
    }
    
}
