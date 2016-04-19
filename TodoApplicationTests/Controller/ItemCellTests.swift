//
//  ItemCellTests.swift
//  TodoApplication
//
//  Created by g tokman on 4/19/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import XCTest
@testable import TodoApplication

class ItemCellTests: XCTestCase {

	// MARK: - Properties

	var tableView: UITableView!
	let myDataSource = FakeDataSource()

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let controller = storyboard.instantiateViewControllerWithIdentifier("ItemListViewController") as! ItemListViewController

		_ = controller.view

		tableView = controller.tableView
		tableView.dataSource = myDataSource
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testSUT_HasNameLabel() {

		let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCellTableViewCell

		XCTAssertNotNil(cell.titleLabel)
	}

	func testSUT_HasLocationLabel() {

		let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCellTableViewCell

		XCTAssertNotNil(cell.locationLabel)
	}

	func testSUT_HasDateLaber() {
		let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCellTableViewCell

		XCTAssertNotNil(cell.dateLabel)
	}

	func testconfigWithItem_SetsLabelTexts() {
		let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCellTableViewCell

		cell.configCellWithItem(ToDoItem(title: "First", itemDescription: nil, timestamp: 1456150025, location: Location(name: "Home")))

		XCTAssertEqual(cell.titleLabel.text, "First")
		XCTAssertEqual(cell.locationLabel.text, "Home")
		XCTAssertEqual(cell.dateLabel.text, "02/22/2016")
	}

	func testTitle_ForCheckedTasks_IsStrokeThrough() {
		let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCellTableViewCell

		let toDoItem = ToDoItem(title: "First", itemDescription: nil, timestamp: 1456150025, location: Location(name: "Home"))

		cell.configCellWithItem(toDoItem, checked: true)
		let attributedString = NSAttributedString(string: "First", attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])

		XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
		XCTAssertNil(cell.locationLabel.text)
		XCTAssertNil(cell.dateLabel.text)
	}
}

extension ItemCellTests {
	class FakeDataSource: NSObject, UITableViewDataSource {
		func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			return 1
		}

		func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
			return UITableViewCell()
		}
	}
}
