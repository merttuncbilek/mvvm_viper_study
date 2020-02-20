//
//  MProductDetailViewController.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 25.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class MProductDetailViewController: BaseMvvMViewController<MProductDetailViewModel> {
    
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    var productId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let productId = productId {
            super.showProgress()
            viewModel.getProductDetail(id: productId)
        }
    }
    
    override func setUpObservers() {
        super.setUpObservers()
        
        viewModel.productDetail.observeNext {[weak self] productDetail in
            self?.dismissProgress()
            guard let productDetail = productDetail else {return}
            self?.setUIElements(with: productDetail)
        }.dispose(in: bag)
    }
    
    fileprivate func setUIElements(with productDetail: ProductDetail) {
        self.title = productDetail.name ?? ""
        self.labelProductName.text = productDetail.name ?? ""
        self.labelPrice.text = "\(productDetail.price ?? 0)"
        self.labelDescription.text = productDetail.description ?? ""
        if let url = URL(string: productDetail.image ?? "") {
            self.imageProduct.kf.setImage(with: ImageResource(downloadURL: url, cacheKey: productDetail.name))
        }
    }
}
