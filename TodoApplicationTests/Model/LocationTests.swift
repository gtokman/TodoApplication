//
//  LocationTests.swift
//  TodoApplication
//
//  Created by g tokman on 4/15/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import XCTest
import CoreLocation
@testable import TodoApplication

class LocationTests: XCTestCase {

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testInit_ShouldSetName() {
		let location = Location(name: "Test name")

		// Test
		XCTAssertEqual(location.name, "Test name", "Initializer should set the name")
	}

	func testInit_ShouldSetNameAndCoordinate() {
		let testCoordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
		let location = Location(name: "", coordinate: testCoordinate)

		// Test
		XCTAssertEqual(location.coordinate?.latitude, testCoordinate.latitude, "Initializer should set latitude")
		XCTAssertEqual(location.coordinate?.longitude, testCoordinate.longitude, "Initializer should set longitude")
	}
}
