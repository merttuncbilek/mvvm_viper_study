//
//  ViewController.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 12.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actionOpenViperController(_ sender: Any) {
        
        if let productsViperContainer = ProductsWireFrame.createProductsView() {
            self.navigationController?.pushViewController(productsViperContainer, animated: true)
        }
        
    }
    
}

