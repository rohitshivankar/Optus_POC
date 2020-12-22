//
//  AddCity_Tests.swift
//  Optus_POCTests
//
//  Created by Rohit on 12/22/20.
//

import XCTest
@testable import Optus_POC

class AddCity_Tests: XCTestCase {

    let cityViewModel = AddCityViewModel()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testToVerifyCityDataExist() {
        let expectation = self.expectation(description: "Application is able to load city data from local JSON file.")
        cityViewModel.readCityDataFromJSON { response in
            switch(response) {
            case .success(let result):
                XCTAssertNotNil(result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 7, handler: nil)
    }
    
    func testCitySearchResultCount() {
        testToVerifyCityDataExist()
        cityViewModel.filterCityDataWith(string: "Pune") {
            XCTAssertEqual(self.cityViewModel.filteredCityList.count, 1)
        }
    }
    
    func testCitySearchZeroResult() {
        testToVerifyCityDataExist()
        cityViewModel.filterCityDataWith(string: "Rohit") {
            XCTAssertEqual(self.cityViewModel.filteredCityList.count, 0)
        }
    }
    
    func testCitySearchResultData() {
        testToVerifyCityDataExist()
        cityViewModel.filterCityDataWith(string: "Pune") {
            let firstSearchedResult = self.cityViewModel.filteredCityList[0]
            XCTAssertEqual(firstSearchedResult.name, "Pune")
        }
    }

}
