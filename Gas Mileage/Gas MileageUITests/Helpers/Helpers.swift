import Foundation
import XCTest

class Helpers: BaseUITest, BaseScreen {
	internal func assertScreenIsDisplayed() {}
	
	/// Waits for the application to launch and ensures it is in the foreground state.
	///
	/// This method launches the application using `launchApp()` and waits for it to reach the foreground state within a predefined timeout.
	/// It runs an XCTActivity to log the step, asserting that the app is running in the foreground. If the application does not reach the foreground state within the timeout duration, the test fails with an error message.
	///
	/// - Returns: Returns `self` to allow for method chaining.
	///
	/// - Important: This method uses an assertion to verify the app's state. If the app does not reach the foreground state within the timeout, it triggers a failure and logs an error message.
	///
	/// - Note: The `@discardableResult` attribute indicates that the caller can ignore the return value if chaining is not needed.
	///
	/// - Example:
	/// ```swift
	/// // Waits for the app to launch and become active
	/// appTester.waitForApplicationToLaunch()
	/// ```
	///
	/// - SeeAlso: `launchApp()` for more information about the app launch method.
	@discardableResult
	func waitForApplicationToLaunch() -> Self {
		launchApp()
		runActivity(.step, "Waiting for the App to be in foreground state") {
			XCTAssert(app.wait(for: .runningForeground,
							   timeout: Timeouts.medium.rawValue),
					  "\(err) App is not in the foreground state after waiting.")
		}
		
		return self
	}
}
