import Foundation
import XCTest

protocol BaseScreen {
	var app: XCUIApplication { get }
	func assertScreenIsDisplayed()
}

extension BaseScreen {
	
	// MARK: - Apps
	var app: XCUIApplication {
		XCUIApplication()
	}
	
	var springboard: XCUIApplication {
		return XCUIApplication(bundleIdentifier: UITestConstant.AppBundleIDs.springboard)
	}
	
	var safariApp: XCUIApplication {
		return XCUIApplication(bundleIdentifier: UITestConstant.AppBundleIDs.safari)
	}
	
	var settingsApp: XCUIApplication {
		return XCUIApplication(bundleIdentifier: UITestConstant.AppBundleIDs.settings)
	}
	
	// MARK: - activity message addons
	var assert: String {
		return Icons.assert.rawValue
	}
	
	var err: String {
		return Icons.error.rawValue
	}
	
	var screen: String {
		return Icons.screen.rawValue
	}
	
	var step: String {
		return Icons.step.rawValue
	}
	
	func runActivity(_ icon: Icons, _ named: String, block: () -> Void) {
		XCTContext.runActivity(named: "\(icon.rawValue) \(named)", block: {_ in
			block()
		})
	}
	
	@discardableResult
	func closeAndReopenTheApp() -> Self {
		app.terminate()
		app.launch()
		return self
	}
}
