//
//  OperationsTableVCTests.swift
//  PepperHSTests
//
//  Created by VCM1 on 11/11/2022.
//

import XCTest
@testable import PepperHS

class OperationsTableVCTests: XCTestCase {

//    func test() {
//        XCTFail("Initial failing test")
//    }
    
        func test_canInit() throws {
            _ = try makeSUT()
        }
    
    func test_viewDidLoad_setTitle() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        XCTAssert((sut.title != nil), "Financial operations")
    }
    
    //sytem under test
    func makeSUT() throws -> FinancialOperationsTableVC{
        let bundle = Bundle(for: FinancialOperationsTableVC.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = sb.instantiateInitialViewController()
        let navigation = try XCTUnwrap(initialVC as? UINavigationController)
        //if we disconect the TableView from UINavigationController from the
        return try XCTUnwrap(navigation.topViewController as? FinancialOperationsTableVC)
    }
    
}
