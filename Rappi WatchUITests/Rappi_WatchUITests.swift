//
//  Rappi_WatchUITests.swift
//  Rappi WatchUITests
//
//  Created by Bryan Caro on 10/28/21.
//

import XCTest

class Rappi_WatchUITests: XCTestCase {
    
    private let app = XCUIApplication()
    
    override func setUp() {
        app.launch()
        
        let nextButton = app.buttons["launchScreenNextButton"]
        nextButton.tap()
        nextButton.tap()
        
        let skipButton = app.buttons["skipMeButton"]
        skipButton.waitForExistence(timeout: 6)
        skipButton.tap()
        
        sleep(2)
    }
    
    func test_filter_type() {
        let tvSerieButton = app.buttons["tvSerieCategoryButton"]
        tvSerieButton.tap()
        
        sleep(2)
        
        let movieButton = app.buttons["movieCategoryButton"]
        movieButton.tap()
        
        sleep(2)
    }
    
    func test_filter_category() {
        let topRatedButton = app.buttons["Flame"]
        topRatedButton.tap()
        
        sleep(2)
        
        let upComingButton = app.buttons["Date And Time"]
        upComingButton.tap()
        
        sleep(2)
        
        let popularButton = app.buttons["Love"]
        popularButton.tap()
        
        sleep(2)
    }
    
    func test_filter_searchbar() {
        let searchBar = app.textFields["SearchFilter"]
        XCTAssertTrue(searchBar.exists, "Text field doesn't exist")
        searchBar.tap()
        searchBar.typeText("Veno")
        app.buttons["Return"].tap()
        
        sleep(5)
    }
}
