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
	@IBOutlet var dataProvider: protocol<UITableViewDataSource, UITableViewDelegate, ItemManagerSettable>!
	let itemManager = ItemManager()

	// MARK: - Life Cycle

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)

		tableView.reloadData()
	}

	override func viewDidLoad() {
		tableView.dataSource = dataProvider
		tableView.delegate = dataProvider
		dataProvider.itemManager = itemManager

		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ItemListViewController.showsDetails(_:)), name: "ItemSelectionNotification", object: nil)
	}

	// MARK: - Actions

	@IBAction func addItem(sender: UIBarButtonItem) {
		if let nextViewController = storyboard?.instantiateViewControllerWithIdentifier("InputViewController") as? InputViewController {

			nextViewController.itemManager = self.itemManager

			presentViewController(nextViewController, animated: true, completion: nil)
		}
	}

	func showsDetails(sender: NSNotification) {
		guard let index = sender.userInfo?["index"] as? Int else { fatalError() }

		if let nextViewController = storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as? DetailViewController {
			nextViewController.itemInfo = (itemManager, index)
			navigationController?.pushViewController(nextViewController, animated: true)
		}
	}
}
