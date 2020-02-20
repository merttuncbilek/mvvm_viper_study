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
        
        self.productsTableViewAdapter.delegate = self
        self.tableViewProducts.delegate = self.productsTableViewAdapter
        self.tableViewProducts.dataSource = self.productsTableViewAdapter
        
        super.showProgress()
        viewModel.fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "PRODUCTS"
    }
    
    override func setUpObservers() {
        super.setUpObservers()
        
        viewModel.products.observeNext {[weak self] products in
            self?.dismissProgress()
            self?.productsTableViewAdapter.products = products.collection
            self?.tableViewProducts.reloadData()
        }.dispose(in: bag)
        
    }
    
    override func handleViewState(_ state: ViewState) {
        super.handleViewState(state)
        
        switch state {
        case ProductsViewState.productsFetched(let success):
            print(#"ViewState is handled \#(success)"#)
        default:
            break
        }
    }
}

extension MProductsViewController: ProductsTableViewAdapterDelegate {
    
    func onItemSelected(at index: Int) {
        viewModel.onProductItemSelected(at: index)
    }
    
}
