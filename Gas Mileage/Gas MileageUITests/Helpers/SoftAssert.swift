import XCTest

/// A utility class for performing non-blocking assertions (soft asserts) in XCUITest.
/// This class allows tests to continue running even if an assertion fails,
/// and reports all collected failures at the end of the test execution.
///
/// - Note: The `SoftAssert` class is implemented as a singleton to maintain a shared instance
///         across multiple screen classes or test methods.
///
/// Usage example:
/// ```swift
/// SoftAssert.shared.assertEqual(actualTitle, expectedTitle, "The title should be correct")
/// SoftAssert.shared.checkForFailures()
/// ```
class SoftAssert {
	
	/// The shared singleton instance of `SoftAssert`.
	static let shared = SoftAssert()
	
	/// An array to store failure messages for all soft asserts.
	private var failures: [String] = []
	
	/// Private initializer to enforce the singleton pattern.
	private init() {}
	
	// MARK: - Assertion Methods
	
	/// Performs a soft assert for a given boolean condition.
	/// If the condition evaluates to `false`, a failure message is stored and the test continues.
	///
	/// - Parameters:
	///   - condition: The condition to be evaluated. If `false`, a failure message is stored.
	///   - message: A descriptive message for the failure.
	///
	/// - Usage example:
	/// ```swift
	/// SoftAssert.shared.assert(element.exists, "Element should be visible")
	/// ```
	func assert(_ condition: @autoclosure () -> Bool,
				_ message: String) {
		if !condition() {
			let failureMessage = "\(Icons.error.rawValue)" + message
			failures.append(failureMessage)
		}
	}

	/// Performs a soft assert for equality between two values.
	/// If the values are not equal, a failure message is stored and the test continues.
	///
	/// - Parameters:
	///   - actual: The actual value obtained.
	///   - expected: The expected value for comparison.
	///   - message: A descriptive message for the failure.
	///
	/// - Usage example:
	/// ```swift
	/// SoftAssert.shared.assertEqual(actualTitle, "Welcome!", "The title should be 'Welcome!'")
	/// ```
	func assertEqual<T: Equatable>(_ actual: T,
								   _ expected: T,
								   _ message: String) {
		if actual != expected {
			let failureMessage = "\(Icons.error.rawValue) Expected '\(expected)', but got '\(actual)'. \(message)"
			failures.append(failureMessage)
		}
	}
	
	/// Stores a failure message without blocking execution.
	/// Use this method when you want to collect errors without asserting immediately.
	///
	/// - Parameters:
	///   - message: A descriptive message for the failure.
	///
	/// - Usage example:
	/// ```swift
	/// SoftAssert.shared.softFail("This test failed without blocking execution")
	/// ```
	func softFail(_ message: String) {
		let failureMessage = "\(Icons.error.rawValue)" + message
		failures.append(failureMessage)
	}

	// MARK: - Failure Checking
	
	/// Checks if there are any accumulated failures and reports them as a single test failure.
	/// If there are no failures, this method does nothing.
	///
	/// - Parameters:
	///   - file: The file in which the failure occurred. The default is the file where this method is called.
	///   - line: The line number on which the failure occurred. The default is the line where this method is called.
	///
	/// - Usage example:
	/// ```swift
	/// SoftAssert.shared.checkForFailures()
	/// ```
	func checkForFailures(file: StaticString = #file,
						  line: UInt = #line) {
		if !failures.isEmpty {
			let combinedMessage = failures.joined(separator: "\n")
			XCTFail(combinedMessage, file: file, line: line)
		}
	}

	// MARK: - Reset
	
	/// Resets the stored failure messages.
	/// This method can be used to clear the state of the `SoftAssert` instance between tests.
	///
	/// - Usage example:
	/// ```swift
	/// SoftAssert.shared.reset()
	/// ```
	func reset() {
		failures.removeAll()
	}
}
