//
//  ItemManager.swift
//  TodoApplication
//
//  Created by g tokman on 4/15/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class ItemManager: NSObject {
	var toDoCount: Int { return toDoItems.count }
	var doneCount: Int { return doneItems.count }
	private var toDoItems = [ToDoItem]()
	private var doneItems = [ToDoItem]()

	var toDoPathURL: NSURL {
		let fileURLs = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)

		guard let documentURL = fileURLs.first else {
			print("Something went wrong. Douments url cound no ve found")
			fatalError()
		}

		return documentURL.URLByAppendingPathComponent("toDoItems.plist")
	}

	override init() {
		super.init()

		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ItemManager.save), name: UIApplicationWillResignActiveNotification, object: nil)

		if let nsToDoItems = NSArray(contentsOfURL: toDoPathURL) {
			for dict in nsToDoItems {
				if let toDoItem = ToDoItem(dict: dict as! NSDictionary) {
					toDoItems.append(toDoItem)
				}
			}
		}
	}

	deinit {
		NSNotificationCenter.defaultCenter().removeObserver(self)
		save()
	}

	// Methods

	func save() {
		var nsToDoItems = [AnyObject]()

		for item in toDoItems {
			nsToDoItems.append(item.plistDict)
		}

		if nsToDoItems.count > 0 {
			(nsToDoItems as NSArray).writeToURL(toDoPathURL, atomically: true)
		}
		else {
			do {
				try NSFileManager.defaultManager().removeItemAtURL(toDoPathURL)
			} catch {
				print(error)
			}
		}
	}

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

	func uncheckItemAtIndex(index: Int) {
		let item = doneItems.removeAtIndex(index)
		toDoItems.append(item)
	}

	func removeAllItems() {
		toDoItems.removeAll()
		doneItems.removeAll()
	}
}