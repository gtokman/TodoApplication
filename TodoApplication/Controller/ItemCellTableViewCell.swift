//
//  ItemCellTableViewCell.swift
//  TodoApplication
//
//  Created by g tokman on 4/18/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class ItemCellTableViewCell: UITableViewCell {

	// MARK: - Properties

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!

	lazy var dateFormatter: NSDateFormatter = {
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "MM/dd/yyyy"

		return dateFormatter
	}()

	func configCellWithItem(item: ToDoItem, checked: Bool = false) {

		if checked {
			let attributedTitle = NSAttributedString(string: item.title, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
			// Config cell with line
			titleLabel.attributedText = attributedTitle
			locationLabel.text = nil
			dateLabel.text = nil
		}
		else {

			// Config cell
			titleLabel.text = item.title
			locationLabel.text = item.location?.name

			if let timestamp = item.timestamp {
				let date = NSDate(timeIntervalSince1970: timestamp)

				dateLabel.text = dateFormatter.stringFromDate(date)
			}
		}
	}
}
