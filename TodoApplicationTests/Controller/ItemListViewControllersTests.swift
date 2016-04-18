//
//  ItemListViewControllersTests.swift
//  TodoApplication
//
//  Created by g tokman on 4/18/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import XCTest
@testable import TodoApplication

class ItemListViewControllersTests: XCTestCase {

	// MARK: - Properties

	var sut: ItemListViewController!

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewControllerWithIdentifier("ItemListViewController") as! ItemListViewController

		_ = sut.view
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func test_TableViewIsNotNilAfterViewDidLoad() {

		XCTAssertNotNil(sut.tableView)
		XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider)
	}

	func testViewDidLoad_ShouldSetTableViewDelegate() {
		XCTAssertNotNil(sut.tableView.delegate)
		XCTAssertTrue(sut.tableView.delegate is ItemListDataProvider)
	}

	func testViewDidLoad_ShouldSetDelegateAndDataSourceToTheSameObject() {
		XCTAssertEqual(sut.tableView.dataSource as? ItemListDataProvider, sut.tableView.delegate as? ItemListDataProvider)
	}
}
