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

	func testEqualItems_ShouldBeEqual() {
		let firstItem = ToDoItem(title: "First")
		let secondItem = ToDoItem(title: "First")

		// Test
		XCTAssertEqual(firstItem, secondItem)
	}

	func testWhenLocationDifferes_ShouldBeNotEqual() {
		let firstItem = ToDoItem(title: "First title", itemDescription: "First description", timestamp: 0.0, location: Location(name: "Home"))
		let secondItem = ToDoItem(title: "First title", itemDescription: "First description", timestamp: 0.0, location: Location(name: "Office"))

		XCTAssertNotEqual(firstItem, secondItem)
	}

	func testWhenOneLocationIsNilAndTheOtherIsnt_ShouldBeNotEqual() {
		let firstItem = ToDoItem(title: "First title", itemDescription: "First description", timestamp: 0.0, location: Location(name: "Home"))
		let secondItem = ToDoItem(title: "First title", itemDescription: "First description", timestamp: 0.0, location: nil)

		// Test
		XCTAssertNotEqual(firstItem, secondItem)
	}

	func testWhnTimestampDiffers_ShouldBeNotEqual() {
		let firstItem = ToDoItem(title: "First title", itemDescription: "First description", timestamp: 1.0)
		let secondItem = ToDoItem(title: "First title", itemDescription: "First description", timestamp: 0.0)

		// Test
		XCTAssertNotEqual(firstItem, secondItem)
	}

	func testWhenDescriptionDifferes_ShouldBeNotEqual() {
		let firstItem = ToDoItem(title: "First title", itemDescription: "First description")
		let secondItem = ToDoItem(title: "First title", itemDescription: "Second description")

		// Test
		XCTAssertNotEqual(firstItem, secondItem)
	}

	func testWhenTitleDifferes_ShouldBeNotEqual() {
		let firstItem = ToDoItem(title: "First title")
		let secondItem = ToDoItem(title: "Second title")

		// Test
		XCTAssertNotEqual(firstItem, secondItem)
	}

	func test_HasPlistDictionaryProperty() {
		let item = ToDoItem(title: "First")
		let dictionary = item.plistDict

		XCTAssertNotNil(dictionary)
		XCTAssertTrue(dictionary is NSDictionary)
	}

	func test_CanBeCreatedFromPlistDictionary() {
		let location = Location(name: "Home")
		let item = ToDoItem(title: "The Title", itemDescription: "The Description", timestamp: 1.0, location: location)

		let dict = item.plistDict

		let recreatedItem = ToDoItem(dict: dict)

		XCTAssertEqual(item, recreatedItem)
	}
}
