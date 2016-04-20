//
//  KeychainAccessible.swift
//  TodoApplication
//
//  Created by g tokman on 4/20/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation

protocol KeychainAccessible {
	func setPassword(password: String, account: String)

	func deletePasswordForAccount(account: String)

	func passwordForAccount(account: String) -> String?
}
