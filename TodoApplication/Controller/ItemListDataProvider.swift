//
//  ItemListDataProvider.swift
//  TodoApplication
//
//  Created by g tokman on 4/18/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

enum Section: Int {
	case ToDo, Done
}

class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {

	// MARK: - Properties

	var itemManager: ItemManager?

	// MARK: - TableViewDataSource

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 2
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let itemManager = itemManager else { return 0 }
		guard let itemSection = Section(rawValue: section) else {
			fatalError()
		}

		let numberOfRows: Int

		switch itemSection {
		case .ToDo:
			numberOfRows = itemManager.toDoCount
		case .Done:
			numberOfRows = itemManager.doneCount
		}
		return numberOfRows
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCellTableViewCell

		guard let itemManager = itemManager else { fatalError() }
		guard let section = Section(rawValue: indexPath.section) else { fatalError() }

		let item: ToDoItem

		switch section {
		case .ToDo:
			item = itemManager.itemAtIndex(indexPath.row)
		case .Done:
			item = itemManager.doneItemAtIndex(indexPath.row)
		}

		cell.configCellWithItem(item)

		return cell
	}

	// MARK: - TableViewDelegate

	func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {

		guard let section = Section(rawValue: indexPath.section) else {
			fatalError()
		}

		let buttonTitle: String

		switch section {
		case .ToDo:
			buttonTitle = "Check"
		case .Done:
			buttonTitle = "Uncheck"
		}

		return buttonTitle
	}
}
