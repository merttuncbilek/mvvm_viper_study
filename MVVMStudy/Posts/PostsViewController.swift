//
//  PostsViewController.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 17.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class PostsViewController: BaseViewController {
    
    @IBOutlet weak var tableViewProducts: UITableView!
    
    var presenter: PostsPresenterToViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewProducts.delegate = self
        tableViewProducts.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "PRODUCTS"
        presenter?.fetchPosts()
    }
}

extension PostsViewController: PostsViewToPresenterProtocol {
    func postsFetched(productResponse: ProductsResponse) {
        tableViewProducts.reloadData()
    }
    
}

extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = presenter?.numberOfProducts() {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCellIndetifier", for: indexPath) as UITableViewCell
        
        guard let product = presenter?.getProductItem(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = product.name ?? ""
        cell.detailTextLabel?.text = "\(product.price ?? 0)"
        if let url = URL(string: product.image ?? "") {
            
            cell.imageView?.kf.setImage(with: ImageResource(downloadURL: url, cacheKey: product.name),  completionHandler: { result in
                tableView.reloadRows(at: [indexPath], with: .none)
            })
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.onProductItemSelected(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
