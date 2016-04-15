//
//  Location.swift
//  TodoApplication
//
//  Created by g tokman on 4/15/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
	let name: String
	let coordinate: CLLocationCoordinate2D?

	init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
		self.name = name
		self.coordinate = coordinate
	}
}