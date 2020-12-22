//
//  Optus_POCTests.swift
//  Optus_POCTests
//
//  Created by Rohit on 12/20/20.
//

import XCTest
@testable import Optus_POC

class Optus_POCTests: XCTestCase {

    let weatherDataViewModel = WeatherDataViewModel()
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
    
    func testGetWeatherDataFromWebService() {
        let expectation = self.expectation(description: "Web Service response successful.")
        weatherDataViewModel.getWeatherForCitiesList { (result) in
            switch(result) {
            case .success(let result):
                XCTAssertNotNil(result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 7, handler: nil)
    }

}
