//
//  APIClient.swift
//  TodoApplication
//
//  Created by g tokman on 4/20/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation

protocol ToDoURLSession {
	func dataTaskWithURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask
}

class APIClient {

	// MARK: - Properties

	lazy var session: ToDoURLSession = NSURLSession.sharedSession()
	var keychainManager: KeychainAccessible?

	// MARK: - Methods

	func loginUserWithName(username: String, password: String, completion: (ErrorType?) -> Void) {

		let allowedCharacters = NSCharacterSet(charactersInString: "/%&=?$#+-~@<>|\\*,.()[]{}^!").invertedSet

		guard let encodedUsername = "dasdom".stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters) else {
			fatalError()
		}

		guard let encodedPassword = "%&34".stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters) else {
			fatalError()
		}

		guard let url = NSURL(string: "https://awesometodos.com/login?username=\(encodedUsername)&password=\(encodedPassword)") else { fatalError() }

		let task = session.dataTaskWithURL(url) { (data, response, error) in

			guard error == nil else {
				completion(WebserviceError.ResponseError)
				return
			}

			if let theData = data {
				do {
					let responseDict = try NSJSONSerialization.JSONObjectWithData(theData, options: [])

					let token = responseDict["token"] as! String

					self.keychainManager?.setPassword(token, account: "token")
				} catch {
					completion(error)
				}
			}
			else {
				completion(WebserviceError.DataEmptyError)
			}
		}
		task.resume()
	}
}

extension NSURLSession: ToDoURLSession { }

enum WebserviceError: ErrorType {
	case DataEmptyError
	case ResponseError
}
