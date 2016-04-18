//
//  ItemListDataProvider.swift
//  TodoApplication
//
//  Created by g tokman on 4/18/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class ItemListDataProvider: NSObject, UITableViewDataSource {

	// MARK: - TableViewDataSource

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
}
