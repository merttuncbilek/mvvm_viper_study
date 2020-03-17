//
//  UIElementsViewController.swift
//  MVVMStudy
//
//  Created by Mert Tuncbilek on 21.02.2020.
//  Copyright © 2020 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import ReactiveKit
import Bond

class UIElementsViewController: BaseMvvMViewController<UIElementsViewModel> {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var switchView: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "UI Elements"
        
        //self.viewModel.startTimer()
    }
    
    override func setUpObservers() {
        //self.viewModel.isSelected.bidirectionalBind(to: switchView.reactive.isOn)
        self.viewModel.isSelected.observeNext{ isSelected in
            self.switchView.isOn = isSelected
        }.dispose(in: bag)
        self.button.reactive.tap.bind(to: self){ $0.viewModel.isSelected.value = !$0.viewModel.isSelected.value  }.dispose(in: bag)
    }
    
}
