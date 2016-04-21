//
//  StoryboardTests.swift
//  TodoApplication
//
//  Created by g tokman on 4/21/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import XCTest
@testable import TodoApplication

class StoryboardTests: XCTestCase {

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testInitialViewController_IsItemListViewController() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)

		let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
		let rootViewController = navigationController.viewControllers[0]

		XCTAssertTrue(rootViewController is ItemListViewController)
	}
}
