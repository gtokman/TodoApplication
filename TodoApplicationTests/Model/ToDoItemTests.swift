//
//  ToDoItemTests.swift
//  TodoApplication
//
//  Created by g tokman on 4/15/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import XCTest
@testable import TodoApplication

class ToDoItemTests: XCTestCase {

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testInit_ShouldSetTitle() {
		let item = ToDoItem(title: "Test title")

		// Test
		XCTAssertEqual(item.title, "Test title", "Initializer should set the item title")
	}

	func testInit_ShouldSetTitleAndDescription() {
		let item = ToDoItem(title: "Test title", itemDescription: "Test description")

		// Test
		XCTAssertEqual(item.itemDescription, "Test description", "Initializer should set the itme description")
	}

	func testInit_ShouldSetTitleAndDescriptionAndTimestap() {
		let item = ToDoItem(title: "Test title", itemDescription: "Test description", timestamp: 0.0)

		// Test
		XCTAssertEqual(0.0, item.timestamp, "Initializer should set the timestamp")
	}

	func testInit_ShouldSetTitleAndDescriptionAndTimestampAndLocation() {
		let location = Location(name: "Test name")
		let item = ToDoItem(title: "Test name", itemDescription: "Test description", timestamp: 0.0, location: location)

		// Test
		XCTAssertEqual(location.name, item.location?.name, "Initializer should set the location")
	}
}
