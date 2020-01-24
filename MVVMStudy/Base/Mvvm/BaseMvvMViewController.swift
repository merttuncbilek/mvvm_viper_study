//
//  BaseMvvMViewController.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 25.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit

class BaseMvvMViewController<VM: BaseViewModelProtocol>: BaseViewController {
    
    var viewModel: VM
    
    required init?(coder: NSCoder) {
        self.viewModel = VM.init()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.viewModel.error <-> {[weak self] error in
            self?.showMessage(error)
        }
        
        self.viewModel.navigationEvent <-> {[weak self] navigation in
            self?.performSegue(withIdentifier: navigation.target.rawValue, sender: navigation.payload)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, let segueIdentifier = TargetScreen.init(rawValue: identifier) {
            switch segueIdentifier {
            case .ProductDetail:
                let productDetailViewController = segue.destination as! MProductDetailViewController
                productDetailViewController.productId = sender as? String
            }
        }
    }
}
