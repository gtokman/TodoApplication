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

	func testItemListViewController_HasAddBarButtonWithSelfAsTarget() {
		XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.target as? UIViewController, sut)
	}

	func testAddItem_PresentsAddItemViewController() {
		XCTAssertNil(sut.presentedViewController)

		guard let addButton = sut.navigationItem.rightBarButtonItem else { XCTFail(); return }

		UIApplication.sharedApplication().keyWindow?.rootViewController = sut

		sut.performSelector(addButton.action, withObject: addButton)

		XCTAssertNotNil(sut.presentedViewController)
		XCTAssertTrue(sut.presentedViewController is InputViewController)

		let inputViewController = sut.presentedViewController as! InputViewController
		XCTAssertNotNil(inputViewController.titleTextField)
	}

	func testItemListVC_SharesItemManagerWithInputVC() {
		XCTAssertNil(sut.presentedViewController)

		guard let addButton = sut.navigationItem.rightBarButtonItem else { XCTFail(); return }

		UIApplication.sharedApplication().keyWindow?.rootViewController = sut

		sut.performSelector(addButton.action, withObject: addButton)

		XCTAssertNotNil(sut.presentedViewController)
		XCTAssertTrue(sut.presentedViewController is InputViewController)

		let inputViewController = sut.presentedViewController as! InputViewController

		guard let inputItemManager = inputViewController.itemManager else { XCTFail(); return }
		XCTAssertTrue(sut.itemManager === inputItemManager)
	}

	func testViewdidLoad_SetsItemManagerToDataProvider() {
		XCTAssertTrue(sut.itemManager === sut.dataProvider.itemManager)
	}

	func test_TableViewDidReloadData() {
		let mockTableView = MockTableView()
		sut.tableView = mockTableView
		sut.beginAppearanceTransition(true, animated: true)
		sut.endAppearanceTransition()

		XCTAssertTrue(mockTableView.dataDidReload)
	}

	func testItemSelectedNofification_PushesDetailVC() {
		let mockNavigationController = MockNavigationController(rootViewController: sut)

		UIApplication.sharedApplication().keyWindow?.rootViewController = mockNavigationController

		_ = sut.view

		NSNotificationCenter.defaultCenter().postNotificationName("ItemSelectionNotification", object: self, userInfo: ["index": 1])

		guard let detailViewController = mockNavigationController.pushedViewController as? DetailViewController else { XCTFail(); return }

		guard let detailItemManager = detailViewController.itemInfo?.0 else { XCTFail(); return }

		guard let index = detailViewController.itemInfo?.1 else { XCTFail(); return }

		_ = detailViewController.view

		XCTAssertNotNil(detailViewController.titleLabel)

		XCTAssertTrue(detailItemManager === sut.itemManager)

		XCTAssertEqual(index, 1)
	}
}

extension ItemListViewControllersTests {

	class MockNavigationController: UINavigationController {
		var pushedViewController: UIViewController?

		override func pushViewController(viewController: UIViewController, animated: Bool) {
			pushedViewController = viewController
			super.pushViewController(viewController, animated: animated)
		}
	}

	class MockTableView: UITableView {
		var dataDidReload = false

		override func reloadData() {
			dataDidReload = true
		}
	}
}
