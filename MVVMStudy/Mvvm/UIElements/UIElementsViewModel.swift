//
//  UIElementsviewModel.swift
//  MVVMStudy
//
//  Created by Mert Tuncbilek on 21.02.2020.
//  Copyright © 2020 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

protocol UIElementsViewModelProtocol: BaseViewModelProtocol {
    var isSelected: Observable<Bool> {get set}
    var actionQuantity: Observable<Int> {get set}
    
    func startTimer()
    func incrementAction()
    
}

class UIElementsViewModel: BaseViewModel, UIElementsViewModelProtocol {
    
    var isSelected = Observable<Bool>(true)
    var actionQuantity = Observable<Int>(0)
    var uiElementsModel: UIElementsModelProtocol
    
    required convenience init() {
        self.init(uiElementsModel: UIElementsModel())
    }
    
    init(uiElementsModel: UIElementsModelProtocol) {
        self.uiElementsModel = uiElementsModel
        super.init()
        super.observeError(on: self.uiElementsModel)
    }
    
    override func setUpObserves() {
        self.isSelected.observeNext { isSelected in
            if isSelected {
                self.actionQuantity.value += 1
                print(#"actionQuantity=#\(self.actionQuantity)"#)
            }
        }.dispose(in: bag)
    }
    
    func startTimer() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 1000)) {
            self.isSelected.send(!self.isSelected.value)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 2000)) {
                self.startTimer()
            }
        }
    }
    
    func incrementAction() {
        
    }
}
