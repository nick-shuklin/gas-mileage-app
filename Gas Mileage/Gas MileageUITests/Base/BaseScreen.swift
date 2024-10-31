import Foundation
import XCTest

/// Protocol defining the basic properties and methods for a screen in the app.
protocol BaseScreen {
	/// The app instance to interact with the UI elements.
	var app: XCUIApplication { get }
	
	/// Asserts that the current screen is displayed by verifying essential elements.
	func assertScreenIsDisplayed()
}

extension BaseScreen {
	
	// MARK: - Apps
	
	/// Returns an instance of the main application.
	var app: XCUIApplication {
		XCUIApplication()
	}
	
	/// Returns an instance of the Springboard application, used to interact with system alerts.
	var springboard: XCUIApplication {
		return XCUIApplication(bundleIdentifier: AppBundleIDs.springboard)
	}
	
	/// Returns an instance of the Safari application.
	var safariApp: XCUIApplication {
		return XCUIApplication(bundleIdentifier: AppBundleIDs.safari)
	}
	
	/// Returns an instance of the Settings application.
	var settingsApp: XCUIApplication {
		return XCUIApplication(bundleIdentifier: AppBundleIDs.settings)
	}
	
	/// The error icon used in the application.
	var err: String {
		return Icons.error.rawValue
	}
	
	/// Runs a specified activity with a given icon and name for more readable test results.
	/// - Parameters:
	///   - icon: The icon to display with the activity name.
	///   - named: The name of the activity.
	///   - block: The closure containing the code to execute for this activity.
	func runActivity(_ icon: Icons, _ named: String, block: () -> Void) {
		XCTContext.runActivity(named: "\(icon.rawValue) \(named)") { _ in
			block()
		}
	}
	
	/// Closes and reopens the application, useful for resetting app state.
	/// - Returns: The instance of the current screen for chaining purposes.
	@discardableResult
	func closeAndReopenTheApp() -> Self {
		app.terminate()
		app.launch()
		return self
	}
}
