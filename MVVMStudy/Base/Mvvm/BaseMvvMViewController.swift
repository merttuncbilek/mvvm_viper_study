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
    
    var viewModel: VM?
    
    func initializeViewModel<VM>() -> VM where VM: BaseViewModelProtocol {
        return VM.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = self.initializeViewModel()
        
        self.viewModel?.error.observe = { error in
            super.showMessage(error)
        }
        
        self.viewModel?.navigationEvent.observe = { navigation in
            self.performSegue(withIdentifier: navigation.target.rawValue, sender: navigation.payload)
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
