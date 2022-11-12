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
    
    func test_viewDidLoad_configureTableView() throws {
        let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.tableView.delegate, "delegate")
        XCTAssertNotNil(sut.tableView.dataSource, "dataSource")
    }
    
    func test_viewDidLoad_initialTVState() throws {
        let sut = try makeSUT()

        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_getJsonOperations() throws {
        let sut = try makeSUT()

        sut.loadViewIfNeeded()

    }
    
    //sytem under test
    func makeSUT() throws -> FinancialOperationsTableVC{
        let bundle = Bundle(for: FinancialOperationsTableVC.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = sb.instantiateInitialViewController()
        let navigation = try XCTUnwrap(initialVC as? UINavigationController)
        //if we disconect the TableView from UINavigationController from the
        let sut = try XCTUnwrap(navigation.topViewController as? FinancialOperationsTableVC)
        // init API just for testing
        sut.api = ApiManagerStub()
        return sut
    }
    
}

// init API just for testing
private class ApiManagerStub: ApiManager{
    override init() {}
    override func loadOperationsFromLocalJson(completion: @escaping (Result<[PepperOperation], Error>) -> Void) {
        
    }
}
