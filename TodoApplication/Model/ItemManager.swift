//
//  ItemManager.swift
//  TodoApplication
//
//  Created by g tokman on 4/15/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation

class ItemManager {
	var toDoCount: Int { return toDoItems.count }
	var doneCount: Int { return doneItems.count }
	private var toDoItems = [ToDoItem]()
	private var doneItems = [ToDoItem]()

	// Methods
	func addItem(item: ToDoItem) {
		if !toDoItems.contains(item) {
			toDoItems.append(item)
		}
	}

	func itemAtIndex(index: Int) -> ToDoItem {
		return toDoItems[index]
	}

	func checkItemAtIndex(index: Int) {
		let item = toDoItems.removeAtIndex(index)
		doneItems.append(item)
	}

	func doneItemAtIndex(index: Int) -> ToDoItem {
		return doneItems[index]
	}

	func removeAllItems() {
		toDoItems.removeAll()
		doneItems.removeAll()
	}
}