//
//  MProductsViewController.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 20.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit

class MProductsViewController: BaseMvvMViewController<MProductsViewModel> {
    
    var productsTableViewAdapter = ProductsTableViewAdapter()
    
    @IBOutlet weak var tableViewProducts: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.products.observe = { products in
            super.dismissProgress()
            
            self.productsTableViewAdapter.products = products
            self.tableViewProducts.reloadData()
        }
        
        self.productsTableViewAdapter.delegate = self
        self.tableViewProducts.delegate = self.productsTableViewAdapter
        self.tableViewProducts.dataSource = self.productsTableViewAdapter
        
        super.showProgress()
        viewModel?.fetchPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "PRODUCTS"
    }
    
    override func initializeViewModel<VM>() -> VM where VM : BaseViewModelProtocol {
        return MProductsViewModel() as! VM
    }
    
    override func observeError() {
        self.viewModel?.error.observe = { error in
            super.showMessage(error)
        }
    }
}

extension MProductsViewController: ProductsTableViewAdapterDelegate {
    
    func onItemSelected(at index: Int) {
        viewModel?.onProductItemSelected(at: index)
    }
    
}
