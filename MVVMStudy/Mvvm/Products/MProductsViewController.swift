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
        
        viewModel.products <-> {[weak self] products in
                self?.dismissProgress()
                
                self?.productsTableViewAdapter.products = products
                self?.tableViewProducts.reloadData()
        }
        
        self.productsTableViewAdapter.delegate = self
        self.tableViewProducts.delegate = self.productsTableViewAdapter
        self.tableViewProducts.dataSource = self.productsTableViewAdapter
        
        super.showProgress()
        viewModel.fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "PRODUCTS"
    }
    
}

extension MProductsViewController: ProductsTableViewAdapterDelegate {
    
    func onItemSelected(at index: Int) {
        viewModel.onProductItemSelected(at: index)
    }
    
}
