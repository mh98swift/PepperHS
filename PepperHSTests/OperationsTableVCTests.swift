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
    
    func test_viewDidLoad_renderOperationsFromJson() throws {
        let sut = try makeSUT()
        sut.loadOperationsFromLocalJson = { completion in
            completion(.success([
                PepperOperation(operationType: "operationType1", operationDesc: "operationDesc1", amount: 1.0, source: "source1", address: "address1", operationId: 1),
                PepperOperation(operationType: "operationType2", operationDesc: "operationDesc2", amount: 2.0, source: "source2", address: "address1", operationId: 2)
            ]))
        }
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
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
        sut.loadOperationsFromLocalJson = { _ in }
        return sut
    }
    
}

// init API just for testing
                            //ApiManager
                            //ApiProtocol
private class ApiManagerStub{
//    override init() {}
//    override func loadOperationsFromLocalJson(completion: @escaping (Result<[PepperOperation], Error>) -> Void) {
//
//    }
    func loadOperationsFromLocalJson(completion: @escaping (Result<[PepperOperation], Error>) -> Void) {
        
    }
}
