//
//  BaseMvvMViewController.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 25.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit
import ReactiveKit

class BaseMvvMViewController<VM: BaseViewModel>: BaseViewController {
    
    var viewModel: VM
    var controllerDisposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        self.viewModel = VM.init()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpObservers()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        controllerDisposeBag.dispose()
    }
    
    func setUpObservers() {
        self.viewModel.error.observeNext {[weak self] error in
            self?.showMessage(error)
        }.dispose(in: bag)
        
        self.viewModel.navigationEvent.observeNext {[weak self] navigation in
            self?.performSegue(withIdentifier: navigation.target.rawValue, sender: navigation.payload)
        }.dispose(in: bag)
        
        self.viewModel.state.observeNext { [weak self] state in
            self?.handleViewState(state)
        }.dispose(in: bag)
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
    
    func handleViewState(_ state: ViewState) {
        
    }
    
    deinit {
        viewModel.disposeBag()
    }
}
