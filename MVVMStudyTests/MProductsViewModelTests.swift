//
//  MProductsViewModelTests.swift
//  MVVMStudyTests
//
//  Created by Mert Tuncbilek on 18.02.2020.
//  Copyright © 2020 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import MVVMStudy

class MProductsViewModelTests: QuickSpec {
    
    var viewModel: MProductsViewModel!
    var model: MockProductsModel!
    
    override func spec() {
        
        self.model = MockProductsModel()
        self.viewModel = MProductsViewModel(model: self.model)
        
        beforeEach {
            
            
        }
        
        describe("App Start") {
            
                it("Product List should be fetched") {
                    self.viewModel.fetchProducts()
                    //expect(self.viewModel.products.value.count) != 0
                }
            
        }
        
    }
    
}
