//
//  APIClientTests.swift
//  TodoApplication
//
//  Created by g tokman on 4/20/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import XCTest
@testable import TodoApplication

class APIClientTests: XCTestCase {

	// MARK: - Properties

	var sut: APIClient!
	var mockURLSession: MockURLSession!

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.

		sut = APIClient()

		mockURLSession = MockURLSession()
		sut.session = mockURLSession
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testLogin_MakesRequestWithUsernameAndPassword() {

		let completion = { (error: ErrorType?) in }
		sut.loginUserWithName("dasdom", password: "%&34", completion: completion)

		XCTAssertNotNil(mockURLSession.completionHandler)

		guard let url = mockURLSession.url else { XCTFail(); return }

		let urlComponents = NSURLComponents(URL: url, resolvingAgainstBaseURL: true)

		// Test
		XCTAssertEqual(urlComponents?.host, "awesometodos.com")

		let allowedCharacters = NSCharacterSet(charactersInString: "/%&=?$#+-~@<>|\\*,.()[]{}^!").invertedSet

		guard let expectedUsername = "dasdom".stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters) else {
			fatalError()
		}

		guard let expectedPassword = "%&34".stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters) else {
			fatalError()
		}

		XCTAssertEqual(urlComponents?.percentEncodedQuery, "username=\(expectedUsername)&password=\(expectedPassword)")
	}

	func testLoginn_XallsResumeOfDataTask() {

		let completion = { (error: ErrorType?) in }
		sut.loginUserWithName("dasdom", password: "1234", completion: completion)

		// Test
		XCTAssertTrue(mockURLSession.dataTask.resumeGotCalled)
	}

	func testLogin_SetsToken() {
		let mockKeychainManager = MockKeychainManager()
		sut.keychainManager = mockKeychainManager

		let completion = { (error: ErrorType?) in }
		sut.loginUserWithName("dasdom", password: "1234", completion: completion)

		let responseDict = ["token": "1234567890"]
		let responseData = try! NSJSONSerialization.dataWithJSONObject(responseDict, options: [])
		mockURLSession.completionHandler?(responseData, nil, nil)

		let token = mockKeychainManager.passwordForAccount("token")

		// Test
		XCTAssertEqual(token, responseDict["token"])
	}

	func testLogin_ThrowsErrorWhenJSONIsInvalid() {
		var theError: ErrorType?
		let completion = { (error: ErrorType?) in
			theError = error
		}

		sut.loginUserWithName("dasdom", password: "1234", completion: completion)

		let responseData = NSData()
		mockURLSession.completionHandler?(responseData, nil, nil)

		// Test
		XCTAssertNotNil(theError)
	}

	func testLoginThrowsErrorWhenDataIsNil() {
		var theError: ErrorType?
		let completion = { (error: ErrorType?) in
			theError = error
		}

		sut.loginUserWithName("dasdom", password: "1234", completion: completion)
		mockURLSession.completionHandler?(nil, nil, nil)

		// Test
		XCTAssertNotNil(theError)
	}

	func testLogin_ThrowsErrorWhenResponseHasError() {
		var theError: ErrorType?
		let completion = { (error: ErrorType?) in
			theError = error
		}

		sut.loginUserWithName("dasdom", password: "1234", completion: completion)

		let responseDict = ["token": "1234567890"]
		let responseData = try! NSJSONSerialization.dataWithJSONObject(responseDict, options: [])
		let error = NSError(domain: "SomeError", code: 1234, userInfo: nil)

		mockURLSession.completionHandler?(responseData, nil, error)

		XCTAssertNotNil(theError)
	}
}

extension APIClientTests {

	class MockKeychainManager: KeychainAccessible {

		var passwordDict = [String: String]()

		func setPassword(password: String, account: String) {
			passwordDict[account] = password
		}

		func deletePasswordForAccount(account: String) {
			passwordDict.removeValueForKey(account)
		}

		func passwordForAccount(account: String) -> String? {
			return passwordDict[account]
		}
	}

	class MockURLSession: ToDoURLSession {

		typealias Handler = (NSData!, NSURLResponse!, NSError!) -> Void

		var completionHandler: Handler?
		var url: NSURL?
		var dataTask = MockURLSessionDataTask()

		func dataTaskWithURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
			self.url = url
			self.completionHandler = completionHandler

			return dataTask
		}
	}

	class MockURLSessionDataTask: NSURLSessionDataTask {
		var resumeGotCalled = false

		override func resume() {
			resumeGotCalled = true
		}
	}
}
