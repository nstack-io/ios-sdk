//
//  GeographyTests.swift
//  NStack
//
//  Created by Chris on 27/10/2016.
//  Copyright © 2016 Nodes ApS. All rights reserved.
//

import XCTest
@testable import NStackSDK_iOS

class GeographyTests: XCTestCase {

    override func setUp() {
        super.setUp()

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

//    func testCountries() {
//        let exp = expectation(description: "Test Geography")
//		NStack.updateCountries { (apiCountries, error) in
//			if let error = error {
//				XCTFail("Countries API call failed: \(error)")
//			} else if apiCountries.isEmpty {
//				XCTFail("Countries API result is empty")
//			} else {
//				if NStack.countries?.isEmpty {
//					XCTFail("Countries property didn't store data properly")
//				}
//                exp.fulfill()
//			}
//
//		}
//        waitForExpectations(timeout: 5, handler: nil)
//    }

}
