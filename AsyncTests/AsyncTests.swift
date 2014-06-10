//
//  AsyncTests.swift
//  AsyncTests
//
//  Created by Andrew Barba on 6/9/14.
//  Copyright (c) 2014 Andrew Barba. All rights reserved.
//

import XCTest
import Async

class AsyncTests: XCTestCase {
    
    func testEach() {
        
        var expectNoErrors = expectationWithDescription("no errors")
        Async
            .each(Array(0..10)) { $1(nil) }
            .success { results in expectNoErrors.fulfill() }
            .error { XCTAssertNil($0) }
        
        var expectErrors = expectationWithDescription("expect errors")
        Async
            .each(Array(0..10)) { $1(NSError()) }
            .success { XCTAssertNil($0)  }
            .error { err in expectErrors.fulfill() }
        
        waitForExpectationsWithTimeout(1.0, handler: nil)
    }
    
    func testEachSeries() {
        
        var expectNoErrors = expectationWithDescription("no errors")
        Async
            .eachSeries(Array(0..10)) { $1(nil) }
            .success { results in expectNoErrors.fulfill() }
            .error { XCTAssertNil($0) }
        
        var expectErrors = expectationWithDescription("expect errors")
        Async
            .eachSeries(Array(0..10)) { $1(NSError()) }
            .success { XCTAssertNil($0)  }
            .error { err in expectErrors.fulfill() }
        
        waitForExpectationsWithTimeout(1.0, handler: nil)
    }
}
