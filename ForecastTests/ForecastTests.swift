//
//  ForecastTests.swift
//  ForecastTests
//
//  Created by José Valderrama on 4/16/18.
//  Copyright © 2018 José Valderrama. All rights reserved.
//

import XCTest
@testable import Forecast

class ForecastTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Asynchronous test: success fast, failure slow
    func testValidForecastData() {
        // Given
        let promise = expectation(description: "Forecast has data!")
        
        // When
        APILayer.getForecastData { (forecastObject, error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let forecast: Forecast = forecastObject as? Forecast,
                let _ = forecast.latitude,
                let _ = forecast.longitude,
                let summary = forecast.summary, !summary.isEmpty {
                print(forecast)
                promise.fulfill()
            } else {
                XCTFail("There is no data")
            }
        }
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
    }
}
