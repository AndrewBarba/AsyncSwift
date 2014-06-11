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
    
    let names = [ "Andrew", "Zach", "Jack", "Art", "Brookes" ]
    
    func testEach() {
        
        var e1 = expectationWithDescription("")
        Async
            .each(names) { println($0); $1(nil) }
            .success { e1.fulfill() }
            .error { XCTAssertNil($0) }
        
        var e2 = expectationWithDescription("")
        Async
            .each(names) { $1(NSError()) }
            .success { XCTAssertNotNil(nil) }
//            .error { XCTAssertNotNil($0) } this causes a crash for some unknown reason
            .error { err in e2.fulfill() }
        
        waitForExpectationsWithTimeout(1.0, handler: nil)
    }
    
    func testMap() {
        
        var e1 = expectationWithDescription("")
        Async
            .map(names) { $1($0.uppercaseString, nil) }
            .success { res in e1.fulfill() }
            .error { XCTAssertNil($0) }
        
        waitForExpectationsWithTimeout(1.0, handler: nil)
    }
}
