//
//  TestExtensions.swift
//  MVVMStudyTests
//
//  Created by Mert TUNÇBİLEK on 24.01.2020.
//  Copyright © 2020 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
        
    func await<T>(function: (@escaping (T) -> Void) -> Void) throws -> T {
        let expectation = self.expectation(description: "Await Operation Expectation")
        var result: T?
        
        function() { value in
            result = value
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        
        guard let wrappedResult = result else {
            throw AwaitError("Operation timeout")
        }
        
        return wrappedResult
    }
    
    func async<T>(function: (@escaping (T) -> Void) -> Void) throws {
        let expectation = self.expectation(description: "Await Operation Expectation")
        var result: T?
        
        function() { value in
            result = value
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func async(function: () -> Void) {
        let expectation = self.expectation(description: "Await Operation Expectation")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 9, execute: {
            expectation.fulfill()
        })
        
        function()
        waitForExpectations(timeout: 10)
        
    }
    
}

class AwaitError: Error {
    let errorDescription: String
    
    init(_ errorDescription: String) {
        self.errorDescription = errorDescription
    }
}
