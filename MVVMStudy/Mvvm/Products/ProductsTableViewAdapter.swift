//
//  ProductsTableViewAdapter.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 23.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol ProductsTableViewAdapterDelegate: class {
    func onItemSelected(at index: Int)
}

class ProductsTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var products: [Product]?
    weak var delegate: ProductsTableViewAdapterDelegate?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCellIndetifier", for: indexPath) as UITableViewCell
        
        guard let product = products?[indexPath.row] else {
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
        self.delegate?.onItemSelected(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
