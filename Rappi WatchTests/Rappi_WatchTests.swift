//
//  Rappi_WatchTests.swift
//  Rappi WatchTests
//
//  Created by Bryan Caro on 10/28/21.
//

import XCTest
@testable import Rappi_Watch

class Rappi_WatchTests: XCTestCase {
    let resource = ServerManager()
    
    func test_getMoviesResource_with_validPage() {
        let expectation = self.expectation(description: "ValidRequest_returns_movieResponse")
        
        let page = 1
        let category = CategoriesModel(ManageCategories.Categories.movies)
        let filter = FilterModel(ManageCategories.Filter.popular)
        
        resource.fetchMovies(filter, category, page: page) { response, error in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_getMoviesResource_with_invalidPage() {
        let expectation = self.expectation(description: "ValidRequest_returns_movieResponse")
        
        let page = 10000
        let category = CategoriesModel(ManageCategories.Categories.movies)
        let filter = FilterModel(ManageCategories.Filter.popular)
        
        resource.fetchMovies(filter, category, page: page) { response, error in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            XCTAssertEqual("Sorry for the inconvenience, please try again later!", error?.localizedDescription)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_getMoviesDetail_with_validId() {
        let expectation = self.expectation(description: "ValidRequest_returns_movieResponse")
        
        let id = 580489
        
        resource.fetchMovieDetail(id: id) { response, error in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            XCTAssertEqual(id, response?.id)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_getMoviesDetail_with_invalidId() {
        let expectation = self.expectation(description: "ValidRequest_returns_movieResponse")
        
        let id = 00000000
        
        resource.fetchMovieDetail(id: id) { response, error in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            XCTAssertEqual("Sorry for the inconvenience, please try again later!", error?.localizedDescription)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
