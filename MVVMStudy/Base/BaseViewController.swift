//
//  BaseViewController.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 17.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var activityIndicatorView: UIActivityIndicatorView?
    
    private func initiateActivityIndicatorView() {
        activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView?.frame = self.view.frame
    }
    
}

extension BaseViewController: BaseViewProtocol {
    
    func showProgress() {
        if activityIndicatorView == nil {
            initiateActivityIndicatorView()
        }
        if let activityIndicatorView = self.activityIndicatorView {
            self.view.addSubview(activityIndicatorView)
            activityIndicatorView.startAnimating()
        }
        
    }
    
    func dismissProgress() {
        if let activityIndicatorView = self.activityIndicatorView {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.removeFromSuperview()
        }
    }
    
    func showMessage(_ message: String) {
        let alertView = UIAlertController.init(title: "Warning", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            
        }))
        self.present(alertView, animated: true, completion: nil)
    }
    
}
