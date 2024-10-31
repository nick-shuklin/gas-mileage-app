import XCTest

/// Base class for UI tests, providing common setup and teardown behavior for all UI tests.
class BaseUITest: XCTestCase {
	/// Alias for `BaseUITest` for use with static properties or methods.
	private typealias Static = BaseUITest
	
	/// The main application instance used to interact with UI elements.
	var app = XCUIApplication()
	
	// MARK: - Lifecycle
	
	/// Sets up class-level resources before any tests are run.
	override class func setUp() {
		super.setUp()
	}
	
	/// Sets up each test method, resetting soft assertions and configuring the test environment.
	override func setUp() {
		super.setUp()
		SoftAssert.shared.reset()
		continueAfterFailure = false
	}
	
	/// Cleans up resources after each test method, terminating the application.
	override func tearDown() {
		super.tearDown()
		app.terminate()
	}
	
	// MARK: - Supporting Methods
	
	/// Launches the application. Additional setup, such as adding UI interruption monitors, can be added here.
	func launchApp() {
		app.launch()
		// TODO: here can be added addUIInterruptionMonitor
	}
}

extension BaseUITest {
	/// Sends the application to the background by pressing the home button.
	public func backgroundApp() {
		XCUIDevice.shared.press(.home)
	}
}
