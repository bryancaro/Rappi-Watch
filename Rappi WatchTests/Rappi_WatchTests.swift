//
//  Rappi_WatchTests.swift
//  Rappi WatchTests
//
//  Created by Bryan Caro on 10/28/21.
//

import XCTest
@testable import Rappi_Watch

class Rappi_WatchTests: XCTestCase {
    var sut: URLSession!
    let networkMonitor = ServerManager?.self
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testValidApiCallGetsHTTPStatusCode200() throws {
        let urlString = "https://api.themoviedb.org/3/tv/90462?api_key=79601b6105dd10b6fa4a11e1a8053a74&language=en-US"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sut.dataTask(with: url) { _, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
}
