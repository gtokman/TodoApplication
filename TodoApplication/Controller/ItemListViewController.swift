//
//  ItemListViewController.swift
//  TodoApplication
//
//  Created by g tokman on 4/18/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {

	// MARK: - Properties

	@IBOutlet var tableView: UITableView!
	@IBOutlet var dataProvider: protocol<UITableViewDataSource, UITableViewDelegate>!

	// MARK: - Life Cycle

	override func viewDidLoad() {
		tableView.dataSource = dataProvider
		tableView.delegate = dataProvider
	}
}
