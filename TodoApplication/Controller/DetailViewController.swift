//
//  DetailViewController.swift
//  TodoApplication
//
//  Created by g tokman on 4/19/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
	// MARK: - Properties

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var mapView: MKMapView!
	var itemInfo: (ItemManager, Int)?
	let dateFormatter: NSDateFormatter = {
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "MM/dd/yyyy"

		return dateFormatter
	}()

	// View Life Cycle

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)

		guard let itemInfo = itemInfo
		else { fatalError() }

		let item = itemInfo.0.itemAtIndex(itemInfo.1)

		titleLabel.text = item.title
		locationLabel.text = item.location?.name
		descriptionLabel.text = item.itemDescription

		if let timestamp = item.timestamp {
			let date = NSDate(timeIntervalSince1970: timestamp)
			dateLabel.text = dateFormatter.stringFromDate(date)
		}

		if let coordinate = item.location?.coordinate {
			let region = MKCoordinateRegionMakeWithDistance(coordinate, 100, 100)
			mapView.region = region
		}
	}

	// MARK: - Helper method
	func checkItem() {
		itemInfo?.0.checkItemAtIndex(itemInfo!.1)
	}
}
