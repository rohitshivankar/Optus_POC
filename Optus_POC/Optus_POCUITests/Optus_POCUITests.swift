//
//  Optus_POCUITests.swift
//  Optus_POCUITests
//
//  Created by Rohit on 12/20/20.
//

import XCTest

class Optus_POCUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testToCheckWeatherListHasCell() {

        let weatherTableView = app.tables.matching(identifier: "Table-WeatherListTableView")
        let firstCell = weatherTableView.cells.element(matching: .cell, identifier: "cityWeatherListCell_0")
        let existencePredicate = NSPredicate(format: "exists == 1")
        let expectationEval = expectation(for: existencePredicate, evaluatedWith: firstCell, handler: nil)
        let mobWaiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == mobWaiter, "Test Case Failed.")
    }
    func testForWeatherListCellSelection() {
        
        let weatherTableView = app.tables.matching(identifier: "Table-WeatherListTableView")
        let firstCell = weatherTableView.cells.element(matching: .cell, identifier: "cityWeatherListCell_0")
        let predicate = NSPredicate(format: "isHittable == true")
        let expectationEval = expectation(for: predicate, evaluatedWith: firstCell, handler: nil)
        let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == waiter, "Test Case Failed.")
        firstCell.tap()
    }
    
    func testForCitySearch() {
        app.navigationBars["Weather App"].buttons["Add"].tap()
        let AddCityTableView = app.tables.matching(identifier: "Table-AddCityTableView")
        app.tables["Empty list"].searchFields["Search by city name"].tap()
        app.tables["Empty list"].searchFields["Search by city name"].typeText("Pune")

        let firstCell = AddCityTableView.cells.element(matching: .cell, identifier: "CityTableViewCell_0")
        XCTAssertTrue(firstCell.exists, "Test Case Passed: 1 results returned")
        XCTAssertTrue(firstCell.staticTexts["Pune, IN"].exists, "Test Case passed: Pune result returned")
    }

}
