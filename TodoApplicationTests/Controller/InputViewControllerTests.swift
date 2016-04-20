//
//  InputViewControllerTests.swift
//  TodoApplication
//
//  Created by g tokman on 4/19/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import XCTest
import CoreLocation
@testable import TodoApplication

class InputViewControllerTests: XCTestCase {

	// MARK: - Properties
	var sut: InputViewController!
	var placemark: MockPlacemark!

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewControllerWithIdentifier("InputViewController") as! InputViewController

		_ = sut.view
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testInputViewController_HasTextFields() {
		XCTAssertNotNil(sut.titleTextField)
		XCTAssertNotNil(sut.dateTextField)
		XCTAssertNotNil(sut.locationTextField)
		XCTAssertNotNil(sut.addressTextField)
		XCTAssertNotNil(sut.descriptionTextField)
	}

	func testInputViewController_HasSaveAndCancelButtons() {
		XCTAssertNotNil(sut.saveButton)
		XCTAssertNotNil(sut.cancelButton)
	}

	func testSave_UsesGeocoderToGetCoordinateFromAddress() {
		sut.titleTextField.text = "Test Title"
		sut.dateTextField.text = "02/22/2016"
		sut.locationTextField.text = "Office"
		sut.addressTextField.text = "Infinite Loop 1, Cupertino"
		sut.descriptionTextField.text = "Test Description"

		let mockGeocoder = MockGeocoder()
		sut.geocoder = mockGeocoder

		sut.itemManager = ItemManager()

		sut.save()

		placemark = MockPlacemark()
		let coordinate = CLLocationCoordinate2DMake(37.3316851, -122.0300674)
		placemark.mockCoordinate = coordinate
		mockGeocoder.completionHandler?([placemark], nil)

		let item = sut.itemManager?.itemAtIndex(0)

		let testItem = ToDoItem(title: "Test Title", itemDescription: "Test Description", timestamp: 1456117200, location: Location(name: "Office", coordinate: coordinate))

		XCTAssertEqual(item, testItem)
	}

	func test_SaveButtonHasSaveAction() {
		let saveButton = sut.saveButton

		guard let actions = saveButton.actionsForTarget(sut, forControlEvent: .TouchUpInside) else {
			XCTFail()
			return
		}

		XCTAssertTrue(actions.contains("save"))
	}

	func testSave_CreatesToDoItemWithTitleDateAndDescription() {
		sut.titleTextField.text = "Test Title"
		sut.dateTextField.text = "02/22/2016"
		sut.descriptionTextField.text = "Test Description"
		sut.locationTextField.text = "Office"

		sut.itemManager = ItemManager()

		sut.save()

		let item = sut.itemManager?.itemAtIndex(0)

		let testItem = ToDoItem(title: "Test Title", itemDescription: "Test Description", timestamp: 1456117200, location: Location(name: "Office"))

		XCTAssertEqual(item, testItem)
	}

	func testSave_CreatesToDoItemWithTitle() {
		sut.titleTextField.text = "Test Title"

		sut.itemManager = ItemManager()

		sut.save()

		let item = sut.itemManager?.itemAtIndex(0)

		let testItem = ToDoItem(title: "Test Title")

		XCTAssertEqual(item, testItem)
	}
}

extension InputViewControllerTests {
	class MockGeocoder: CLGeocoder {
		var completionHandler: CLGeocodeCompletionHandler?

		override func geocodeAddressString(addressString: String, completionHandler: CLGeocodeCompletionHandler) {
			self.completionHandler = completionHandler
		}
	}

	class MockPlacemark: CLPlacemark {
		var mockCoordinate: CLLocationCoordinate2D?

		override var location: CLLocation? {
			guard let coordinate = mockCoordinate else { return CLLocation() }

			return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
		}
	}
}